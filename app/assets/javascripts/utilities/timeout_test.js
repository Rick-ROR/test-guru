document.addEventListener('turbolinks:load', function() {

    var timeoutRaw = document.querySelector('.timer')

    function timer_text(time) {
        minutes = ('0' + Math.floor(time / 60)).slice(-2)
        seconds = ('0' + time % 60).slice(-2)
        timeoutHtml.item(1).textContent = `${minutes}: ${seconds}`
    }

    function timer() {
        if (timeout_secs > 0 ) {
            timer_text(timeout_secs)
            timeout_secs -= 1
        } else if (timeout_secs <= 0 && timeout_secs > -15) {
            timeout_secs -= 1
            timeoutRaw.classList.add('hide')
            document.querySelector('.ended').classList.remove('hide')
        }else {
            window.location.href = document.location + '/result'
        }
    }

    if (timeoutRaw) {
        var timeoutHtml = timeoutRaw.getElementsByTagName("span");
        var timeout_secs = timeoutRaw.dataset.timeout
        setInterval(timer, 1000)
    }
})
