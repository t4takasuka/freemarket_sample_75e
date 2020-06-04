document.addEventListener(
  "DOMContentLoaded", e => {
    if (document.getElementById("token_submit") != null) {
      Payjp.setPublicKey("pk_test_4ddfb6a6b775ccdf45b834a8"); 
      let btn = document.getElementById("token_submit"); 
      btn.addEventListener("click", e => {  
        e.preventDefault(); 
        let card = {  
          number: document.getElementById("card_number").value,
          cvc: document.getElementById("cvc").value,
          exp_month: document.getElementById("card_exp_month").value,
          exp_year: document.getElementById("card_exp_year").value
        }; 
        Payjp.createToken(card, (status, response) => {
          // カード情報をpayjpに送りカードトークンを(response.id)を受け取る。
          if (status === 200) {  // 正常な値の場合 
            $("#card_number").removeAttr("name");
            $("#cvc").removeAttr("name");
            $("#exp_month").removeAttr("name");
            $("#exp_year").removeAttr("name"); 
            // name属性を削除することにより、dataベースに送るのを防ぐ。
            $("#card_token").append(
              $('<input type="hidden" name="payjp-token">').val(response.id)
              // <input type="hidden" name="payjp-token" value= response.id>が#card_tokenに追加される。
            ); 
            document.inputForm.submit(); // inputFormのsubmitを発動。（上記で停止していた）
            alert("登録が完了しました"); 
          } else {
            alert("カード情報が正しくありません。");
          }
        });
      });
    }
  },
  false
);