//global variables
let pageCount;//页面数
let count;//图片总数
let requestURL;//要请求的url，如searchResults, collections, photos
let requestData;//查询条件
let currentPage;//当前页码
const pageSize = 8;//一页展示多少图片
const paginationSize = 10;//分页条最多有多少个页码

//请求第一页时先获取总的结果数，之后就不用查找所有结果再筛选，而是直接根据page进行sql查找
function firstPage(countURL,picturesURL,data) {
    requestURL = picturesURL;
    requestData = data;
    $.ajax({
        url:countURL,
        type: "POST",
        data: data,
        success(data) {
            count = data;
            pageCount = Math.ceil(data/pageSize);
            display(1);
        }
    })
}

//display one page
function display(currPage) {
    currentPage = currPage;
    //display page navigation
    pagination(currPage);
    //get results and display
    resultOfPage(currPage)
}

//page navigation
function pagination(currPage) {
    let h = '';
    h += '<p class="help-block">共查到<strong>'+ count +'</strong>张图片,有<strong>'+ pageCount +'</strong>页</p>'
    if(count > 0){
        let start = 1;
        let end = pageCount;
        if(end - start + 1 > paginationSize){
            start = currPage > 5 ? (currPage - 5) : 1;
            end =  start + 9 > pageCount ? pageCount : (start + 9);
        }
        if(currPage == start){//leftest
            h += '<li class="disabled">\n' +
                '      <span aria-label="Previous">\n' +
                '        <span aria-hidden="true">&laquo;</span>\n' +
                '      </span>\n' +
                '    </li>'
        }
        else{
            h += '<li onclick="display('+ (currPage - 1) +')">\n' +
                '      <span aria-label="Previous">\n' +
                '        <span aria-hidden="true">&laquo;</span>\n' +
                '      </span>\n' +
                '    </li>'
        }
        for(let i = start;i <= end;i++){
            if(i == currPage){
                h += '<li class="active">\n' +
                    '      <span>'+ i +' <span class="sr-only">(current)</span></span>\n' +
                    '    </li>'
            }
            else{
                h += '<li onclick="display('+ i +')">\n' +
                    '      <span>'+ i +'</span>\n' +
                    '    </li>'
            }
        }
        if(currPage == end){//rightest
            h += '<li class="disabled">\n' +
                '      <span aria-label="Next">\n' +
                '        <span aria-hidden="true">&raquo;</span>\n' +
                '      </span>\n' +
                '    </li>'
        }
        else{
            h += '<li onclick="display('+ (currPage + 1) +')">\n' +
                '      <span aria-label="Next">\n' +
                '        <span aria-hidden="true">&raquo;</span>\n' +
                '      </span>\n' +
                '    </li>'
        }
    }
    $('#pagination').html(h)
}

function resultOfPage(page) {
    $.ajax({
        url:requestURL,
        type:"POST",
        data:requestData+"&page="+page+"&pageSize="+pageSize,
        dataType:"json",    //数据类型为json格式
        contentType: "application/x-www-form-urlencoded;charset=UTF-8",
        success(data){
            // console.log("search success")
            if(data.hasOwnProperty("pictures")){
                // console.log(data.pictures)
                displayPictures(data.pictures)
            }
        }
    })
}

//display pictures, !!id = results
function displayPictures(pictures) {
    let h = '';
    pictures.forEach(function (pictureElement) {
        h +='<div class="picture">\n'
        h +='        <a href="details.jsp?imageID='+ pictureElement.id +'">' +
            '               <img src="resources/travel-images/square-medium/'+ pictureElement.path +'" alt="..." class="myImage">' +
            '        </a>\n'
        h +='        <h6><strong>'+ pictureElement.title +'</strong></h6>  <strong>author</strong>:'+ pictureElement.author +'\n'
        if(requestURL.indexOf('collections') != -1){
            //collections
            h += '<button type="button" class="btn btn-primary btn-sm myButton" onclick="cancelCollection('+ pictureElement.id +')">★取消收藏</button>\n'
        }
        else if(requestURL.indexOf('photos') != -1){
            //photos
            h += '<button type="button" class="btn btn-success btn-sm deleteButton" onclick="confirmDelete('+ pictureElement.id +')">删除</button>\n';
            h += '<button type="button" class="btn btn-warning btn-sm updateButton" onclick="updatePhoto('+ pictureElement.id +')">修改</button>\n';
        }
        h +=' </div>'
    })
    $('#results').html(h);
}