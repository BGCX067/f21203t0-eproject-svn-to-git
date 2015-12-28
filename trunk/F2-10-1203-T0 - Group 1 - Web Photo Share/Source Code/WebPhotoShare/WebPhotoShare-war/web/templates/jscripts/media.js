jQuery(document).ready(function($) {
	function getScrollTop() {
		var scrOfY = 0;
		if (typeof (window.pageYOffset) == "number") {
			// Netscape compliant
			scrOfY = window.pageYOffset;
		} else if (document.body && (document.body.scrollLeft || document.body.scrollTop)) {
			// DOM compliant
			scrOfY = document.body.scrollTop;
		} else if (document.documentElement && (document.documentElement.scrollLeft || document.documentElement.scrollTop)) {
			// IE6 Strict
			scrOfY = document.documentElement.scrollTop;
		}
        return scrOfY;
    } // end of getScrollTop
    var $allVideos = $(".pin-image iframe"), $fluidEl = $(".pin-image");
    $allVideos.each(function() {
        $(this).data('aspectRatio', this.height / this.width).removeAttr('height').removeAttr('width');
    });
    $(window).resize(function() {
        var newWidth = $fluidEl.width();
        $allVideos.each(function() {
            var $el = $(this);
            $el.width(newWidth).height(newWidth* $el.data('aspectRatio'));
        });
    }).resize();
});

var BrowserDetect = {
    init : function() {
        this.browser = this.searchString(this.dataBrowser) || "An unknown browser";
        this.version = this.searchVersion(navigator.userAgent) || this.searchVersion(navigator.appVersion) || "an unknown version";
        this.OS = this.searchString(this.dataOS) || "an unknown OS";
    },
    searchString : function(data) {
        for ( var i = 0; i < data.length; i++) {
            var dataString = data[i].string;
            var dataProp = data[i].prop;
            this.versionSearchString = data[i].versionSearch || data[i].identity;
            if (dataString) {
                if (dataString.indexOf(data[i].subString) != -1)
                    return data[i].identity;
            } else if (dataProp)
                return data[i].identity;
        }
    },
    searchVersion : function(dataString) {
        var index = dataString.indexOf(this.versionSearchString);
        if (index == -1)
            return;
        return parseFloat(dataString.substring(index + this.versionSearchString.length + 1));
    },
	dataBrowser : [
        {
            string : navigator.userAgent,
            subString : "Chrome",
            identity : "Chrome"
        }, {
            string : navigator.userAgent,
            subString : "OmniWeb",
            versionSearch : "OmniWeb/",
            identity : "OmniWeb"
        }, {
            string : navigator.vendor,
            subString : "Apple",
            identity : "Safari",
            versionSearch : "Version"
        }, {
            prop : window.opera,
            identity : "Opera"
        }, {
            string : navigator.vendor,
            subString : "iCab",
            identity : "iCab"
        }, {
            string : navigator.vendor,
            subString : "KDE",
            identity : "Konqueror"
        }, {
            string : navigator.userAgent,
            subString : "Firefox",
            identity : "Firefox"
        }, {
            string : navigator.vendor,
            subString : "Camino",
            identity : "Camino"
        }, { // for newer Netscapes (6+)
            string : navigator.userAgent,
            subString : "Netscape",
            identity : "Netscape"
        }, {
            string : navigator.userAgent,
            subString : "MSIE",
            identity : "Explorer",
            versionSearch : "MSIE"
        }, {
            string : navigator.userAgent,
            subString : "Gecko",
            identity : "Mozilla",
            versionSearch : "rv"
        }, { // for older Netscapes (4-)
            string : navigator.userAgent,
            subString : "Mozilla",
            identity : "Netscape",
            versionSearch : "Mozilla"
        }
    ],
    dataOS : [
        {
            string : navigator.platform,
            subString : "Win",
            identity : "Windows"
        }, {
            string : navigator.platform,
            subString : "Mac",
            identity : "Mac"
        }, {
            string : navigator.userAgent,
            subString : "iPhone",
            identity : "iPhone/iPod"
        }, {
            string : navigator.platform,
            subString : "Linux",
            identity : "Linux"
        }
    ]
};
BrowserDetect.init();

function checkBrowser() {
	if (BrowserDetect.OS == 'Windows' || BrowserDetect.OS == 'Mac' || (BrowserDetect.OS == 'Linux' && BrowserDetect.browser != 'Mozilla' && BrowserDetect.version != 'unknown') || (BrowserDetect.browser == 'Firefox')) {
		return true;
	} else {
		return false;
	}
}

function strpos(haystack, needle, offset) {
	var i = haystack.indexOf(needle, offset);
	return i >= 0 ? i : false;
}

var oldurlpin = '';
function checkHash() {
	hash = window.location.pathname;
	if (oldurlpin != hash) {
		(function($) {
			$('.overlay').remove();
			$("body").removeClass('no_scroll');
			oldurlpin = '';
		})(jQuery);
	} else {
		setTimeout("checkHash()", 100);
	}
}

function frameFitting() {
	if (document.getElementById('pin_iframe') && document.getElementById('pin_iframe').contentWindow.document.body) {
		var h = 0;
		if (BrowserDetect.browser == 'Safari' || BrowserDetect.browser == 'Chrome') h = 0;
		document.getElementById('pin_iframe').height = document .getElementById('pin_iframe').contentWindow.document.body.scrollHeight + h + 'px';
	}
	setTimeout("frameFitting()", 500);
}

(function($) {
	if (checkBrowser()) {
		$(window).scroll(function() {
			if ($(this).scrollTop()) {
				$('.scroll_top').stop(true, true).fadeIn();
			} else {
				$('.scroll_top').stop(true, true).fadeOut();
			}
		});
	}
	$(document).ready(function() {
        function pin_image_click(a) {
            hash = window.location.pathname;
            if (oldurlpin != hash) {
                var atr_link = $(this).attr("href");
                var html_to_prepend = '<div class="overlay"><div class="pin_container"><div class="close_icon"></div><iframe id="pin_iframe" frameborder="0" scrolling="no" allowtransparency="true"></iframe></div></div>';
                $("body").prepend(html_to_prepend);
                atr_linkk = atr_link + '&ovr=1';
                var myIframe = document.getElementById('pin_iframe');
                myIframe.src = atr_linkk;
                $("body").addClass('no_scroll'); // body no scrolling
                history.pushState(null, null, atr_link );
                oldurlpin = window.location.pathname;
                setTimeout("checkHash()", 500);
                setTimeout("frameFitting()", 1000);
            }
            return false;
        }
        var $container = $('#main_content_area');
        $container.imagesLoaded(function() {
            $container.masonry({
                itemSelector : '.pin_box',
                isAnimated : true,
                animationOptions : {
                    duration : 750,
                    easing : 'linear',
                    queue : true
                }
            });
        });
        $container.infinitescroll({
                navSelector : '#page-nav', // selector for the paged navigation
                nextSelector : '#page-nav a.pager-next', // selector for the NEXT link (to page 2)
                itemSelector : '.pin_box',
                loading : {
                    msgText : "<em>Loading the next set of posts...</em>",
                    finishedMsg : 'No more pins to load.',
                    img : 'templates/images/media_loading.gif'
                },
                state : {
                    currPage : 1
                },
                path: function (path) {
                    var href1 = $('#page-nav a.pager-next').attr('href');
                    var href2 = href1.match(/^(.*?page=)2(.*|$)/).slice(1);
                    var href3 = href2[0].replace('page=', 'page=' + path);
                    href1 = [href3];
                    return href1;
                  }
            },
            // trigger Masonry as a callback
            function(newElements) {
            // hide new items while they are loading
                var $newElems = $(newElements).css({opacity : 0});
                // ensure that images load before adding to masonry layout
                $newElems.imagesLoaded(function() {
                    window.a_second++;
                    $newElems.addClass('second_'+ a_second);
                    $newElems.animate({opacity : 1});
                    $container.masonry('appended',$newElems,true);
                    if (checkBrowser()) {
                        $('.pin_box a.action-pin').click(pin_image_click);
                    }
                });
            });
        if (checkBrowser()) {
            $('.pin_box a.action-pin').click(pin_image_click);
            $('body').click(function(event) {
                if (!$(event.target).closest('.pin_container iframe').length && $('.pin_container iframe').length && $('.pin_box a').length) {
                    history.back();
                };
            });
        }
    });
})(jQuery);