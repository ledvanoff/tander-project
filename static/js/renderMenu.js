const brandName = 'TANDER';
const brandLink = '#';

const urls = {
    'Home':'/',
    'Add comment':'/comment',
    'View comments':'/view',
    'Statistics':'#'
}
const makeMenuItems = (urls)=>{
    let lis = '';
    for (const [key, value] of Object.entries(urls)) {
        lis += `<li class="pure-menu-item"><a href="${value}" class="pure-menu-link">${key}</a></li>`
    }
    return lis
}
const html = `<div class="pure-menu pure-menu-horizontal">
<a href="${brandLink}" class="pure-menu-heading pure-menu-link">${brandName}</a>
<ul class="pure-menu-list">
    ${makeMenuItems(urls)}
</ul>
</div>`

let renderDiv = document.getElementById('menu');
renderDiv.innerHTML = html;