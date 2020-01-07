let $errMsg = document.querySelector('.error-message');
let $succMsg = document.querySelector('.success-message');

const getCitiesByRegion = async function($region){
    let selectedRegionId = $region.options[$region.selectedIndex].value;
    const resp = await fetch('/cities', {
        method: 'POST',
        body: `json_request {"id":${selectedRegionId}}`
    });
    const parse = await resp.text();
    const jsonify = JSON.parse(parse);
        
    let options = '';
    for(let city of jsonify){      
        let option = `<option class="city-opt" value="${city.id}">${city.city_name}</option>`
        options+=option;
    }
    return options
}

const doValidate = (data)=>{
    const required = ['last-name','name','comment'];
    const rePhone = /^([0|\+[0-9]{1,5})?([7-9][0-9]{9})$/;
    const reEmail = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
    ///
    for(const [key, value] of Object.entries(data)){
        if(required.indexOf(key) !=-1 && !value){
            document.getElementById(`#${key}`).classList.add('error-input');
            $errMsg.innerHTML = 'Не заполнены обязательные поля';
            $errMsg.classList.remove('d-none');
            return false
        }
    }
    if(data.phone && !rePhone.test(data.phone)){
        document.getElementById('phone').classList.add('error-input');
        $errMsg.innerHTML = 'Телефон должен быть в формате +XXXXXXXXXXX (11 цифр, например +79991234567)';
        $errMsg.classList.remove('d-none');
        return false
    }
    if(data.email && !reEmail.test(data.email)){
        document.getElementById('email').classList.add('error-input');
        $errMsg.innerHTML = 'Email должен быть в формате example@example.ru';
        $errMsg.classList.remove('d-none');
        return false
    }
    return true
}

const clearErr = ()=>{
    ///
    $errMsg.classList.add('d-none');
    $succMsg.classList.add('d-none');
    let errInputs = document.querySelectorAll('.error-input');
    for(elem of errInputs){
        elem.classList.remove('error-input');
    }
}

const addComment = async function(data){
    data = JSON.stringify(data);
    console.log(data);
    const resp = await fetch('/addcomment', {
        method: 'POST',
        body: `json_request ${data}`
    });
    const parse = await resp.text();
    const jsonify = JSON.parse(parse);
    if(jsonify.status == 'err'){
        $errMsg.innerHTML = `Невозможно добавить комментарий - Ошибка сервера: ${jsonify.err_text}`;
        $errMsg.classList.remove('d-none');
        return
    }else{
        $succMsg.innerHTML = `<span>Комментарий добавлен!</span><br><a href="/view">Cписок всех комментариев</a>`;
        $succMsg.classList.remove('d-none');
        return
    }
    
}

window.onload = async function(){
    const resp = await fetch('/regions');
    const parse = await resp.text();
    const jsonify = await JSON.parse(parse);
    let $region = document.getElementById('region');
    let $city = document.getElementById('city');
    let regionOptions = '';
    for(let region of jsonify){      
        let option = `<option class="region-opt" value="${region.id}">${region.region_name}</option>`
        regionOptions+=option;
    }

    $region.innerHTML = regionOptions;
        
    $city.innerHTML = await getCitiesByRegion($region);

    $region.onchange = async function(){
        $city.innerHTML = await getCitiesByRegion($region);
    }
    

    let commentForm = document.querySelector('#comment-form');
    
    commentForm.addEventListener("submit", async function(e){
        e.preventDefault();
        clearErr();
        let form = document.querySelector('#comment-form');
        let data = new FormData(form);
        let formData = {};

        for(const [key, value] of data.entries()){
            formData[key]=value
        }
        console.log(formData);
        let valid = doValidate(formData);
        if(!valid){return}
        await addComment(formData)

    });
    
}