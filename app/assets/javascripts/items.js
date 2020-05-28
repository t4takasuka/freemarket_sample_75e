$(document).on('turbolinks:load', () => {
  // 画像用のinputを生成する関数
  const buildFileField = (index) => {
    const html = `<div data-index="${index}" class="js-file_group">
                    <input class="js-file" type="file"
                    name="item[itemimgs_attributes][${index}][image]"
                    id="item_itemimgs_attributes_${index}_image"><br>
                    <div class="js-remove">削除</div>
                  </div>`;
    return html;
  }

  let fileIndex = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  $('#itemimg-box').on('change', '.js-file', function (e) {
    $('#itemimg-box').append(buildFileField(fileIndex[0]));
    fileIndex.shift();
    fileIndex.push(fileIndex[fileIndex.length - 1] + 1)
  });

  $('#itemimg-box').on('click', '.js-remove', function () {
    $(this).parent().remove();
    if ($('.js-file').length == 0) $('#itemimg-box').append(buildFileField(fileIndex[0]));
  });
});