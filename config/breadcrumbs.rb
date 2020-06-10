# ルート
crumb :root do
  link "トップページ", root_path
end

# マイページ
crumb :mypage do
  link "マイページ", users_mypage_users_path
  parent :root
end

crumb :showItem do
  link "出品一覧", user_path(current_user.id)
  parent :mypage
end

crumb :buyItem do
  link "購入一覧", users_buy_users_path
  parent :mypage
end

crumb :card do
  link "支払い方法", new_card_path
  parent :mypage
end

# カテゴリー
crumb :category do
  link "カテゴリー一覧", categories_path
  parent :root
end

crumb :categoryChild do |categoryChild|
  categoryChild = Category.find(params[:id])
  link categoryChild.name, categories_path
  parent :category
end