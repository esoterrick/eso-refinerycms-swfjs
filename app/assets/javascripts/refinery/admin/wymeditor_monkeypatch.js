$insert_video_link = "<ul id='add_swf'><li><a href='/refinery/videos/insert?dialog=true'>Add SWF</a></li></ul>";
window.onload = function ()
{
    if ($.wymeditors(0)) {
        $('.wym_area_top').append($insert_video_link);
        init_modal_dialogs();
    }
};

onCloseDialog = function(){
   $('iframe#dialog_iframe').attr('src', '');
};

