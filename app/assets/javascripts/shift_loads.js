
let runOnReady = () =>{
  console.log('this worked')
  attachListenerToDatePicker()
}

let handelFormSubmission = () => {
  let start_date = document.getElementById('start_date').value
  let end_date = document.getElementById('end_date').value
  let body = {start_date: start_date, end_date: end_date}
  fetch(`/shift_loads_data?start_date=${start_date}&end_date=${end_date}`)
    .then(res => {
      return res.json()
    })
    .then((json) =>{
      createExpertLoadChat(json.labels, json.experts_on, json.q_count);
    })
    .catch(error => {
      alert('Something has gone wrong. And not in a good way.')
    })
}

let resetChart = () =>{
  let oldResults = document.getElementById("myChart");
  let resultsContainer = document.getElementById("results-graph")
  if (oldResults != undefined) {oldResults.remove()}

  resultsContainer.innerHTML = '<canvas id="myChart" width="400" height="200"></canvas>';
}

let createExpertLoadChat = (labels, experts_on, q_count) => {

  resetChart();

  console.log('chart did clear')

  let ctx = document.getElementById("myChart");
  let myChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: labels,
        datasets: [{
            type: 'bar',
            label: '# of Experts On',
            data: experts_on,
            backgroundColor: 'rgba(255, 99, 132, 0.2)',
            borderColor: 'rgba(255,99,132,1)',
            borderWidth: 1
        },
        {
            type: 'line',
            label: '# of Qs Asked',
            data: q_count,
            backgroundColor: 'rgba(31, 192, 250, 0.2)',
            borderColor: 'rgba(31, 192, 250, 1)',
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero:true
                }
            }]
        }
    }
  });
}

let attachListenerToDatePicker = () => {
  let submit = document.getElementById('submit')
  $(submit).on('click', (e)=>{
    e.preventDefault();
    handelFormSubmission();
  })
}

$(document).ready(runOnReady);
