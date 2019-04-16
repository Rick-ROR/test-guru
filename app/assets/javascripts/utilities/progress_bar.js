document.addEventListener('turbolinks:load', function() {

    var progressRaw = document.querySelector('.progress-bar')
    var progress = progressRaw.dataset.progress.split(" / ")
    progressPercentage = progress[0] / progress[1] * 100
    console.log(progressPercentage + '%')
    console.log(progressRaw.className)
    console.log(progressRaw)

    progressRaw.style.width = progressPercentage + '%'
})
