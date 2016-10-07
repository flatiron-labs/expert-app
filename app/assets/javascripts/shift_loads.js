
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
      debugger;
      return res.json()
    })
    .then((json) =>{
      debugger;
    })
    .catch(error => {
      debugger;
    })
}

let attachListenerToDatePicker = () => {
  let submit = document.getElementById('submit')
  $(submit).on('click', (e)=>{
    e.preventDefault();
    handelFormSubmission();
  })
}

$(document).ready(runOnReady);
