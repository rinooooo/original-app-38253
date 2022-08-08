window.addEventListener('load', function(){
  let text = document.getElementById('tabelog');
  let btn = document.getElementById('tabelogbtn');

  btn.addEventListener('click', function() {
    info = text.value.split(/\n/);

    let shop = info[0];
    let num = info[1];
    let address = info[2];
    let link = info[3];
    
    document.getElementById('shop-name').value += shop;
    document.getElementById('address').value += address;
    document.getElementById('phone_number').value += num;
    document.getElementById('url').value += link;

  })
});