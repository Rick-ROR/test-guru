document.addEventListener('turbolinks:load', function() {

    var progressRaw = document.querySelector('.progress-bar')
    if (progressRaw) {
        var progress = progressRaw.dataset.progress.split(" / ")
        progressPercentage = progress[0] / progress[1] * 100
        progressRaw.style.width = progressPercentage + '%'
    }
})
