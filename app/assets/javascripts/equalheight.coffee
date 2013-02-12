<html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
<body>
<pre>
###
/*--------------------------------------------------------------------
* The following source code is a modified version of the original plugin "EqualHeights" for jQuery.
*
* JQuery Plugin: "EqualHeights"
* by:    Scott Jehl, Todd Parker, Maggie Costello Wachs (http://www.filamentgroup.com)
*
* Copyright (c) 2009 Filament Group
* Licensed under GPL (http://www.opensource.org/licenses/gpl-license.php)

* JQuery Plugin : "EqualHeights-Light"
* Modified by : Michael (http://www.webdevcodex.com)
* Description : Does not use px-em dependencies based from the original version. Also fixes a small bug which does not allow divs to be of equal heights if there are more than 2 divs.

2/12/2013: Convert javascript to coffescript.

------------------------------------------------------------------------*/
###

jQuery.fn.equalheight = ->
  jQuery(this).each ->
    currentTallest = 0 #create currentTallest var
    
    #go through every child of the mother div
    jQuery(this).children().each (i) ->
      
      #keep checking every childs height and get the height of the tallest div
      currentTallest = jQuery(this).height()  if jQuery(this).height() > currentTallest

    #set currentTallest as pixels
    currentTallest = currentTallest + "px"
    
    #If browser is Microsoft Internet explorer, then "use" css "height: yypx"
    jQuery(this).children().css height: currentTallest  if jQuery.browser.msie and jQuery.browser.version is 6.0
    
    #use css "min-height or height: yypx"
    jQuery(this).children().css "min-height": currentTallest
this
