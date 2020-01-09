//рендеринг итоговой таблицы
const createTable = (jsonify)=>{
    ths='';
    for (const [key, value] of Object.entries(jsonify[0])) {
        ths += `<th>${key}</th>`
    }
    ths+=`<th>Action</th>`
    let thead = `<tr>${ths}</tr>`;
    let tbody = '';
    jsonify.reverse().map((val)=>{
            let tds =''
            for (const [key, value] of Object.entries(val)) {
                tds += `<td>${value}</td>`
            }
            tds+= `<td><button value="${val.id}" class="delete-comment button-error pure-button">Delete</button></td>`
            let row = `<tr id=tr${val.id}>${tds}</tr>`
            tbody+=row
        });
    let table = `<table class="w100 pure-table"><thead>${thead}</thead><tbody>${tbody}</tbody></table>`;
    
    return table
}
const deleteComment = async function(id){
    const resp = await fetch('/delete', {
        method: 'DELETE',
        body: `json_request {"id":${id}}`
    });
    const parse = await resp.text();
    const jsonify = JSON.parse(parse);
    if(jsonify.status == 'err'){
        return alert(`Failed to delete comment! Reason: ${jsonify.err_text}`)
    }
    return jsonify.status
}


window.onload = async function() {
    const resp = await fetch('/test');
    const parse = await resp.text();
    const jsonify = JSON.parse(parse);
    
    let renderDiv = document.getElementById('render');
    renderDiv.innerHTML = createTable(jsonify);

    window.onclick = async (e)=>{
        if(e.target.className.indexOf("delete-comment")>-1){
                let id = e.target.value;
                let delResult = await deleteComment(id);
                console.log(delResult);
            
                if(delResult == 'ok'){
                    let tr = document.querySelector(`#tr${id}`);
                    tr.remove()
                }

        }
        
    }
    
    
};