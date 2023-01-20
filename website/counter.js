
var requestOptions = {
    method: 'POST',
    redirect: 'follow'
  };

fetch('https://48jydx6oe7.execute-api.us-east-2.amazonaws.com/crc/counter', requestOptions)
    .then(response => response.json())
    .then(response => {document.getElementById("visitorCount").innerHTML = response.body.count})
    .then(data => console.log(data));
