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
    // console.log('pswd = ' + password.value)
    // console.log('pswd_confirm = ' + password_confirmation.value)

    if ((password_confirmation.value == null || password_confirmation.value == '') || (password.value == null || password.value == '')) {
        showAlert('',false)
        // console.log('false')
    } else if (password.value == password_confirmation.value) {
        // console.log('You')
        showAlert('Пароли совпадают', true, 'alert-success')
    } else {
        // console.log('Fuck')
        showAlert('Пароли не совпадают!', true, 'alert-warning')
    }
}

function showAlert(msg='', hide=true, alert='alert-danger') {
    var alert_div = document.createElement('div')
    alert_div.classList.add('flash', 'alert', alert)
    if (!hide) { alert_div.classList.add('hide') }
    alert_div.classList.add('mt-3')
    alert_div.textContent = msg
    // console.log(alert_div)

    var alert_div_old = document.querySelector('.flash')
    console.log(alert_div_old.parentElement.className)
    var name = '.' + alert_div_old.parentElement.className.replace(/\s+/g,".")
    // document.querySelector('.row').replaceChild(flash_div, current_flash_div)
    console.log(document.querySelector('.col.col-md-4'))
    console.log(name)
    console.log(document.querySelector(name))
    document.querySelector(name).replaceChild(alert_div, alert_div_old)
    // document.querySelector('.col.col-md-4').replaceChild(alert_div, alert_div_old)
}
