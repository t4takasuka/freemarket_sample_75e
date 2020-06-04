$(function(){
  function appendOption(category){
    const html = `<option value="${category.name}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }

  function appendChildrenBox(insertHTML){
    let childSelectHtml = "";
    childSelectHtml = `<div class="item-category" id="children_wrapper">
                        <div class="item-category__title">
                          <select class="item-category__wrapper" id="child_category" name="category_id">
                            <option value="----" data-category="----">選択してください</option>
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
                                <select class="item-category__wrapper" id="grandchild_category" name="category_id">
                                  <option>選択してください</option>
                                  ${insertHTML}
                                </select>
                                <i class='fas fa-chevron-down item-category__icon'></i>
                              </div>
                            </div>`;
    $(".detail-category").append(grandchildSelectHtml);
  }
  // 親カテゴリー選択時のイベント
  $("#parent_category").on('change', function(){
    const parent_name = document.getElementById("parent_category").value;
    // console.log(parent_name);
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
    }
  });
  // 子カテゴリー選択後のイベント
  $(".detail-category").on("change", "#child_category", function(){
    const childId = $("#child_category option:selected").data("category");
    if (childId != ""){
      $.ajax({
        url: 'get_category_grandchildren',
        type: 'GET',
        data: {child_id:childId},
        dataType:'json'
      })
      .done(function(grandchildren){
        if (grandchildren != ""){
          $("#grandchildren_wrapper").remove();
          let insertHTML = "";
          grandchildren.forEach(function(grandchild){
            insertHTML += appendOption(grandchild)
          });
          appendGrandchildrenBox(insertHTML);
        }
      })
      .fail(function(){
        alert("カテゴリーの取得に失敗しました。")
      })
    }else{
      $("#grandchildren_wrapper").remove();
    }
  });
});