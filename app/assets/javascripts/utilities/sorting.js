document.addEventListener('turbolinks:load', function() {
    var control = document.querySelector('.sort-by-title')
    // console.log (control)

    if (control) control.addEventListener('click', sortRowsByTitle)
})

function sortRowsByTitle() {
    var table = document.querySelector('table')
    var rows = table.querySelectorAll('tr')
    // console.log (rows)

// NodeList
// https://developer.mozilla.org/ru/docs/Web/API/NodeList
    var rows = table.querySelectorAll('tr')
    var sortedRows = []

// select all table rows except the first one which is the header
    for (var i = 1; i < rows.length; i++) {
        sortedRows.push(rows[i])
    }
    // console.log(sortedRows)

    // sortedRows.sort(compareRows) // <=>

    // var arrowUp = this.querySelector('.octicon-arrow-up')
    //
    // console.log(arrowUp)
    // sortedRows.sort(compareRowsAsc)

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

    sortedTable.classList.add('table')
    sortedTable.appendChild(rows[0])

    for (var i = 0; i < sortedRows.length; i++) {
        sortedTable.appendChild(sortedRows[i])
        }
    // console.log(sortedTable)
    table.parentNode.replaceChild(sortedTable, table)
}

function compareRowsAsc(rowl, row2) {
    var testTitlel = rowl.querySelector('td').textContent
    var testTitle2 = row2.querySelector('td').textContent
    if (testTitlel < testTitle2) { return -1 }
    if (testTitlel > testTitle2) { return 1 }
    return 0
}

function compareRowsDesc2(rowl, row2) {
    var testTitlel = rowl.querySelector('td').textContent
    var testTitle2 = row2.querySelector('td').textContent
    if (testTitlel < testTitle2) { return 1 }
    if (testTitlel > testTitle2) { return -1 }
    return 0
}

function compareRowsDesc (rowl, row2) {
    // var res = (compareRowsAsc(rowl, row2) / -1)
    // if (!isFinite(res)) { return 0 }
    // return res
    // console.log(Math.abs(compareRowsAsc))
    return (compareRowsAsc(rowl, row2) / -1)
}
