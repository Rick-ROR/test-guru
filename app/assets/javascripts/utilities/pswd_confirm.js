document.addEventListener('turbolinks:load', function()
{
    var password = document.querySelector('#user_password')
    var password_confirmation = document.querySelector('#user_password_confirmation');

    if (password) { password.addEventListener('input', validatePasswordFields) }
    if (password_confirmation) { password_confirmation.addEventListener('input', validatePasswordFields) }
});

function validatePasswordFields() {
    var password = document.querySelector('#user_password')
    var password_confirmation = document.querySelector('#user_password_confirmation');

    if ((password_confirmation.value == null || password_confirmation.value == '') || (password.value == null || password.value == '')) {
        showAlert('',true)
    } else if (password.value == password_confirmation.value) {
        showAlert('Пароли совпадают', false, 'alert-success')
    } else {
        showAlert('Пароли не совпадают!', false, 'alert-warning')
    }
}

function showAlert(msg='', hide=false, alert='alert-danger') {
    var alert_div = document.createElement('div')
    alert_div.classList.add('flash', 'alert', alert)
    if (hide) { alert_div.classList.add('hide') }
    alert_div.classList.add('mt-3')
    alert_div.textContent = msg

    var alert_div_old = document.querySelector('.flash')
    // не нашёл варианта лучше как скормить querySelector className c пробелами
    var name = '.' + alert_div_old.parentElement.className.replace(/\s+/g,".")
    document.querySelector(name).replaceChild(alert_div, alert_div_old)
}
