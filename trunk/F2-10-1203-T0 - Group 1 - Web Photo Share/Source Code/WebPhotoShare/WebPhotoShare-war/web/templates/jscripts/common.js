$(function() {
	var	$categoryButton	=	$('.btnCategory');
	var $categoryMenu	=	$('.categoryMenu');
	$categoryButton.bind('click',function(){
		var $this = $(this);
		$this.toggleClass('slided selected');
		$categoryMenu.slideToggle(300);
	});
})
// back to top
jQuery("#back-top").hide();     
// fade in #back-top
jQuery(function () {
	jQuery(window).scroll(function () {
		if (jQuery(this).scrollTop() > 100) {
			jQuery('#back-top').fadeIn();
		} else {
			jQuery('#back-top').fadeOut();
		}
	}); 
	// scroll body to 0px on click
	jQuery('#back-top a').click(function () {
		jQuery('body,html').animate({
			scrollTop: 0
		}, 800);
		return false;
	});
});
function imagePreview(upload) {
    if (upload.files && upload.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            $('#imagePreview').attr('src', e.target.result);
        }
        reader.readAsDataURL(upload.files[0]);
    }
}