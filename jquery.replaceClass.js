/**
 * Replace existing class foo with class bar.
 * Pass an optional true value as the final argument, and the class bar will be added if it is not already applied.
 *
 * For instance:
 *
 *     $(el).replaceClass('hilite', 'off');        // replace the class 'hilite' with the class 'off'
 *                                                 // does nothing if el does not have the class 'hilite'
 *
 *     $(el).replaceClass('hilite', 'off', true);  // apply the class 'off' to el
 *                                                 // and if el has the class 'hilite', remove it
 *
 *     $(el).toggleClass('hilite', 'off');         // if el has the class 'hilite' then replace it with 'off'
 *                                                 // or if el has the class 'off' then replace it with 'hilite'
 *                                                 // does nothing if el has neither the class 'hilite' nor the class 'off'
 *
 *     $(el).toggleClass('hilite', 'off', true);   // as the previous example, but if el does not have the class 'hilite' nor 'off'
 *                                                 // then apply the class 'off'
 *
 *
 * @see http://snipplr.com/view/3338/toggle-classname/
 *
 */

(function($){
   $.fn.extend({

                 toggleClass : function() {

                   return this.each(function() {

                                      

                                    });
                 }
               });
 })(jQuery);
