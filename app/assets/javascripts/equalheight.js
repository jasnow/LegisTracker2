/*
 * The following source code is a modified version of the original plugin
 * "EqualHeights" for jQuery.
 *
 * JQuery Plugin: "EqualHeights"
 * by:    Scott Jehl, Todd Parker, Maggie Costello Wachs
 # (http://www.filamentgroup.com)
 *
 * Copyright (c) 2009 Filament Group
 * Licensed under GPL (http://www.opensource.org/licenses/gpl-license.php)

 * JQuery Plugin : "EqualHeights-Light"
 * Modified by : Michael (http://www.webdevcodex.com)
 * Description : Does not use px-em dependencies based from the original
 *     version. Also fixes a small bug which does not allow divs to be
 * of equal heights if there are more than 2 divs.
 *
 * 2/12/2013: Convert javascript to coffescript.
 * 5/2/2019: Converted it back to javascript.
*/

/*
 * decaffeinate suggestions:
 * DS102: Remove unnecessary code created because of implicit returns
 * Full docs: https://github.com/decaffeinate/decaffeinate/blob/master/docs/suggestions.md
 */
jQuery.fn.equalheight = function() {
  return jQuery(this).each(function() {
    let currentTallest = 0; //create currentTallest var

    //go through every child of the mother div
    jQuery(this).children().each(function(i) {

      //keep checking every childs height and get the height of the tallest div
      if (jQuery(this).height() > currentTallest) { return currentTallest = jQuery(this).height(); }
    });

    //set currentTallest as pixels
    currentTallest = currentTallest + "px";

    //If browser is Microsoft Internet explorer, then "use" css "height: yypx"
    if (jQuery.browser.msie && (jQuery.browser.version === 6.0)) { jQuery(this).children().css({height: currentTallest}); }

    //use css "min-height or height: yypx"
    return jQuery(this).children().css({"min-height": currentTallest});
  });
};
