class ItemsController < ApplicationController
  before_action :set_item, except: %i[index new create get_category_children get_category_grandchildren get_size purchaseCompleted]
  before_action :move_to_session, except: %i[index show]
  before_action :set_card, only: %i[purchaseConfilmation pay]
  before_action :set_sending_destinations, only: %i[purchaseConfilmation]
  before_action :set_api_key
  before_action :return_unless_seller, only: [:edit, :update, :destroy]
  require 'payjp'

  def index
    @items = Item.all
    @categories = Category.order(:id)
  end

  def new
    @item = Item.new
    @item.images.new
    @category_parent = Category.where(ancestry: nil)
  end

  def get_category_children
    @category_children = Category.find(params[:parent_name].to_s).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find(params[:child_id].to_s).children
  end

  # 孫カテゴリー後のサイズのアクション
  def get_size
    selected_grandchild = Category.find(params[:grandchild_id].to_s)
    if related_size_parent = selected_grandchild.item_sizes[0]
      @sizes = related_size_parent.children
    else
      selected_child = Category.find(params[:grandchild_id].to_s).parent
      if related_size_parent = selected_child.item_sizes[0]
        @sizes = related_size_parent.children
      end
    end
  end

  def create
    @item = Item.new(item_params)
    if @item.save!
      redirect_to root_path, notice: "商品を出品しました"
    else
      @item.images.build
      flash[:alert] = "必須項目を正確に入力してください"
      render :new
    end
  end

  def show
    @categories = Category.order(:id)
    @category = Category.find(@item.category_id)
    @user = User.find(@item.seller_id)
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to root_path, notice: "商品を更新しました"
    else
      flash.now[:alert] = "必須項目をすべて入力してください"
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to root_path, notice: "商品を削除しました"
    else
      redirect_to root_path, notice: "削除に失敗しました"
      render :show
    end
  end

  def purchaseConfilmation
    if @card.blank?
      flash[:alert] = '購入前にクレジットカードを登録してください'
      redirect_to new_card_path
    else
      set_item
      set_sending_destinations
      set_customer
      set_card_information
      @card_brand = @card_information.brand
      case @card_brand
      when "Visa"
        @card_src = "Visa.svg"
      when "MasterCard"
        @card_src = "master-card.svg"
      when "JCB"
        @card_src = "jcb.svg"
      when "American Express"
        @card_src = "american_express.svg"
      when "Diners Club"
        @card_src = "dinersclub.svg"
      when "Discover"
        @card_src = "discover.svg"
      end
    end
  end

  def pay
    charge = Payjp::Charge.create(
      amount: @item.price, # 支払金額を引っ張ってくる
      customer: @card.customer_id, # 顧客ID
      currency: 'jpy' # 日本円
    )
    @item_buyer = Item.find(params[:id])
    @item_buyer.update(buyer_id: current_user.id)
    redirect_to purchaseCompleted_item_path # 購入完了ページへ
  end

  def purchaseCompleted; end

  private

  def item_params
    params.require(:item).permit(:name, :price, :introduction, :brand_id, :prefecture_code, :category_id, :trading_status, :size_id, :item_condition_id, :postage_payer_id, :postage_type_id, :preparation_day_id, images_attributes: %i[src _destroy id]).merge(seller_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_session
    redirect_to new_user_registration_path unless user_signed_in?
  end

  def set_api_key
    Payjp.api_key = Rails.application.credentials[:payjp][:secret_key]
  end

  def set_customer # 保管した顧客IDでpayjpから情報取得
    @customer = Payjp::Customer.retrieve(@card.customer_id)
  end

  def set_card_information # 保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
    @card_information = @customer.cards.retrieve(@card.card_id)
  end

  def set_card
    @card = Card.where(user_id: current_user.id).first
  end

  def set_sending_destinations
    @address = SendingDestination.where(user_id: current_user.id).first
  end

  def return_unless_seller
    return unless @item&.seller_id == current_user.id
  end
end
