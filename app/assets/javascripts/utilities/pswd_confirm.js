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

    if (password_confirmation.value == '' || password.value == '') {
        document.querySelector(`.alert-danger`).classList.add('hide')
        document.querySelector(`.alert-success`).classList.add('hide')
    } else if (password.value == password_confirmation.value) {
        document.querySelector(`.alert-danger`).classList.add('hide')
        document.querySelector(`.alert-success`).classList.remove('hide')
    } else {
        document.querySelector(`.alert-danger`).classList.remove('hide')
        document.querySelector(`.alert-success`).classList.add('hide')
    }
}
