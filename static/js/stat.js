// Listen for click on the document
/* <a href="#content-1" class="accordion-toggle">Show more 1</a>
<div class="accordion-content" id="content-1">
  Content goes here...
</div> */

const createTable = (jsonify)=>{

    let thead = `<tr><th>Регион</th><th>Всего комментариев</th></tr>`;
    let tbody = '';
    let i = 0;
    jsonify.map((val)=>{
            let citiesInfo = "";
            for (const [key, value] of Object.entries(val.cities)) {
                let cityInfo = `<span class="city-info">${key} : ${value}</span><br>`;
                citiesInfo+=cityInfo;
            }
            let tds = `<td><a href="#content-${i}" class="accordion-toggle">${val.region}</a><div class="accordion-content" id="content-${i}"><div class="cities-info">${citiesInfo}</div></div></td><td>${val.total}</td>`
            let row = `<tr>${tds}</tr>`
            tbody+=row
            i++
        });
    let table = `<table class="pure-table"><thead>${thead}</thead><tbody>${tbody}</tbody></table>`;
    
    
    return table
}

window.onload = async function() {
    let renderDiv = document.getElementById('render');
    const resp = await fetch('/getstat');
    const parse = await resp.text();
    const jsonify = JSON.parse(parse);
    console.log(jsonify);
    if('warn' in jsonify){
        renderDiv.innerHTML = `<h3>${jsonify.warn}</h3>`;
        return
    }

    renderDiv.innerHTML = createTable(jsonify);
    document.addEventListener('click', function (event) {
        if (!event.target.classList.contains('accordion-toggle')) return;
        let content = document.querySelector(event.target.hash);
        if (!content) return;
        event.preventDefault();
        if (content.classList.contains('active')) {
          content.classList.remove('active');
          return;
        }
        let accordions = document.querySelectorAll('.accordion-content.active');
        for (let i = 0; i < accordions.length; i++) {
          accordions[i].classList.remove('active');
        }
        content.classList.toggle('active');
      })
    
};