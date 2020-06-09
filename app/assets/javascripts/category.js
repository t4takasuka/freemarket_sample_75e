$(document).on('turbolinks:load',function(){
  function appendOption(category){
    const html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }
  function appendSizeOption(size){
    const html = `<option value="${size.id}">${size.size}</option>`;
    return html;
  }

  function appendChildrenBox(insertHTML){
    let childSelectHtml = "";
    childSelectHtml = `<div class="item-category" id="children_wrapper">
                        <div class="item-category__title">
                          <select class="item-category__wrapper" id="child_category" name="item[category_id]">
                            <option value="" data-category="">選択してください</option>
                            ${insertHTML}
                          </select>
                          <i class='fas fa-chevron-down item-category__icon'></i>
                        </div>
                      </div>`;
    $(".detail-category").append(childSelectHtml);
  }
  // 孫のセレクトボックス表示
  function appendGrandchildrenBox(insertHTML){
    let grandchildSelectHtml = "";
    grandchildSelectHtml = `<div class="item-category" id="grandchildren_wrapper">
                              <div class="item-category__title">
                                <select class="item-category__wrapper" id="grandchild_category" name="item[category_id]">
                                  <option value="" data-category="">選択してください</option>
                                  ${insertHTML}
                                </select>
                                <i class='fas fa-chevron-down item-category__icon'></i>
                              </div>
                            </div>`;
    $(".detail-category").append(grandchildSelectHtml);
  }

  function appendSizeBox(insertHTML){
    let sizeSelectHtml = "";
    sizeSelectHtml = `<div class="item-size" id= "size_wrapper">
                        <label class="item-size__title" for="サイズ">サイズ</label>
                        <span class='form__request'>必須</span>
                        <div class='item-size__wrapper'>
                          <div class='item-size__wrapper--box'>
                            <select class="item-size__wrapper--select" id="item_size_id" name="item[item_size_id]">
                              <option value="">選択してください</option>
                              ${insertHTML}
                            <select>
                            <i class='fas fa-chevron-down item-size__icon'></i>
                          </div>
                        </div>
                      </div>`;
    $(".detail-category").append(sizeSelectHtml);
  }
  // 親カテゴリー選択時のイベント
  $("#parent_category").on('change', function(){
    const parent_name = document.getElementById("parent_category").value;
    if (parent_name != ""){
      $.ajax({
        url: '/items/get_category_children',
        type: 'GET',
        data: {parent_name:parent_name},
        dataType: 'json'
      })
      .done(function(children){
        $("#children_wrapper").remove();
        $("#grandchildren_wrapper").remove();
        $("#size_wrapper").remove();
        let insertHTML = "";
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendChildrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました。');
      })
    }else{
      $("#children_wrapper").remove();
      $("#grandchildren_wrapper").remove();
      $("#size_wrapper").remove();
    }
  });
  // 子カテゴリー選択後のイベント
  $(".detail-category").on("change", "#child_category", function(){
    const childId = $("#child_category option:selected").data("category");
    if (childId != ""){
      $.ajax({
        url: '/items/get_category_grandchildren',
        type: 'GET',
        data: {child_id:childId},
        dataType:'json'
      })
      .done(function(grandchildren){
        if (grandchildren.length != 0){
          $("#grandchildren_wrapper").remove();
          $("#size_wrapper").remove();
          let insertHTML = "";
          grandchildren.forEach(function(grandchild){
            insertHTML += appendOption(grandchild);
          });
          appendGrandchildrenBox(insertHTML);
        }
      })
      .fail(function(){
        alert("カテゴリーの取得に失敗しました。");
      })
    }else{
      $("#grandchildren_wrapper").remove();
      $("#size_wrapper").remove();
    }
  });
  // サイズを出現させるイベント
  $('.detail-category').on('change','#grandchild_category', function(){
    const grandchildId = $("#grandchild_category option:selected").data('category');
    if (grandchildId != ""){
      $.ajax({
        url: '/items/get_size',
        type: 'GET',
        data: { grandchild_id:grandchildId },
        dataType: 'json'
      })
      .done(function(sizes){
        $("#size_wrapper").remove();
        if (sizes.length != 0) {
        let insertHTML = "";
          sizes.forEach(function(size){
            insertHTML += appendSizeOption(size);
          });
          appendSizeBox(insertHTML);
        }
      })
      .fail(function(){
        alert('サイズの取得に失敗しました。');
      })
    }else{
      $("#size_wrapper").remove();
    }
  });
});