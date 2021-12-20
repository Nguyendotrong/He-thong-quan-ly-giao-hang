// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';
const labels_month = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
const chartsByCanvasId = {};
// Area Chart Example
var ctx = document.getElementById("myAreaChart");


const handleChangeSelectYear = async (year) => {

    // console.log($(this))

    // console.log(year)
    let data = await fetch('/admin/static/?year=' + year).then(res => res.json())

    console.log(data.months)
    let data_month = []
    let label = Object.keys(data.months).map(k => {
        data_month.push(data.months[k])
        return labels_month[parseInt(k) - 1]
    })
    // console.log(label, data_month)


    let canvasid = "myAreaChart"
    destroyChartIfNecessary(canvasid)
    let chart = chart_bar(canvasid, label, data_month,)
    registerNewChart(canvasid, chart)

    canvasid = "myBarChart"
    destroyChartIfNecessary(canvasid)
    let chartline = draw_line_chart(canvasid, label, data_month,)
    registerNewChart(canvasid, chartline)
}

select_year = $("div.legend input[name='checkbox_year']")

let datenow = new Date()
select_year.change(async function (e) {
    let year = e.target.value
    console.log("handel change:", year)
    handleChangeSelectYear(year)
    let month = datenow.getMonth() + 1
    // console.log(year !== datenow.getFullYear().toString(), month)
    if (year !== datenow.getFullYear().toString()) {
        month = 1
    }
    // draw_chart_month(year, month)
})

handleChangeSelectYear(datenow.getFullYear())

const chart_bar = (canvans_id, label, data,) => {
    let ctx = $("#" + canvans_id)

    return new Chart(ctx, {
        type: 'line',
        data: {
            labels: label,
            datasets: [{
                label: "Sessions",
                lineTension: 0.3,
                backgroundColor: "rgba(2,117,216,0.2)",
                borderColor: "rgba(2,117,216,1)",
                pointRadius: 5,
                pointBackgroundColor: "rgba(2,117,216,1)",
                pointBorderColor: "rgba(255,255,255,0.8)",
                pointHoverRadius: 5,
                pointHoverBackgroundColor: "rgba(2,117,216,1)",
                pointHitRadius: 50,
                pointBorderWidth: 2,
                data: data,
            }],
        },
        options: {
            scales: {
                xAxes: [{
                    time: {
                        unit: 'date'
                    },
                    gridLines: {
                        display: false
                    },
                    ticks: {
                        maxTicksLimit: 7
                    }
                }],
                yAxes: [{
                    ticks: {
                        min: 0,
                        max: Math.max(...data) + 5,
                        maxTicksLimit: 5
                    },
                    gridLines: {
                        color: "rgba(0, 0, 0, .125)",
                    }
                }],
            },
            legend: {
                display: false
            }
        }
    });
}

const destroyChartIfNecessary = (canvasId) => {
    if (chartsByCanvasId[canvasId]) {
        chartsByCanvasId[canvasId].destroy();
    }
}

const registerNewChart = (canvasId, chart) => {
    chartsByCanvasId[canvasId] = chart;
}

const draw_line_chart  = (canvans_id, label, data,) => {
    let ctx = $("#" + canvans_id)
    return new Chart(ctx, {
        type: 'bar',
        data: {
            labels: label,
            datasets: [{
                label: "Revenue",
                backgroundColor: "rgba(2,117,216,1)",
                borderColor: "rgba(2,117,216,1)",
                data: data,
                barPercentage: 0.7,
                minBarLength: 20,
                borderWidth: 1,

            }],
        },
        options: {
            scales: {
                xAxes: [{
                    time: {
                        unit: 'month'
                    },
                    gridLines: {
                        display: false
                    },
                    ticks: {
                        maxTicksLimit: 6
                    }
                }],
                yAxes: [{
                    ticks: {
                        min: 0,
                        max: Math.max(...data) + 5,
                        maxTicksLimit: 5
                    },
                    gridLines: {
                        display: true
                    }
                }],
            },
            legend: {
                display: false
            }
        }
    });
}
