document.addEventListener('turbolinks:load', function() {
    var control = document.querySelector('.sort-by-title')

    if (control) control.addEventListener('click', sortRowsByTitle)
})

function sortRowsByTitle() {
    var table = document.querySelector('table')
    var rows = table.querySelectorAll('tr')

// NodeList
// https://developer.mozilla.org/ru/docs/Web/API/NodeList
    var rows = table.querySelectorAll('tr')
    var sortedRows = []

// select all table rows except the first one which is the header
    for (var i = 1; i < rows.length; i++) {
        sortedRows.push(rows[i])
    }


    if (this.querySelector('.octicon-arrow-up').classList.contains('hide')) {
        sortedRows.sort(compareRowsAsc)
        this.querySelector('.octicon-arrow-up').classList.remove('hide')
        this.querySelector('.octicon-arrow-down').classList.add('hide')
    } else {
        sortedRows.sort(compareRowsDesc)
        this.querySelector('.octicon-arrow-up').classList.add('hide')
        this.querySelector('.octicon-arrow-down').classList.remove('hide')
    }

    var sortedTable	= document.createElement('table')

    var head = document.querySelector('thead').className
    // console.log(head)
    sortedTable.createTHead().classList.add(head);

    sortedTable.classList.add('table')
    sortedTable.querySelector('thead').appendChild(rows[0])

    for (var i = 0; i < sortedRows.length; i++) {
        sortedTable.querySelector('thead').appendChild(sortedRows[i])
        }

    table.parentNode.replaceChild(sortedTable, table)
}

function compareRowsAsc(rowl, row2) {
    var testTitlel = rowl.querySelector('td').textContent
    var testTitle2 = row2.querySelector('td').textContent
    if (testTitlel < testTitle2) { return -1 }
    if (testTitlel > testTitle2) { return 1 }
    return 0
}

function compareRowsDesc (rowl, row2) {
    return (compareRowsAsc(rowl, row2) / -1)
}
