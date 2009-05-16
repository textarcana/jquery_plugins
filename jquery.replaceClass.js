/**
 * Replace existing class foo with class bar.
 * Pass an optional true value as the final argument, and the class bar will be added if it is not already applied.
 *
 * For instance:
 *
 *     $(el).replaceClass('off', 'hilite');        // replace the class 'off' with the class 'hilite'
 *                                                 // does nothing if el does not have the class 'hilite'
 *
 *     $(el).replaceClass('off', 'hilite', true);  // apply the class 'hilite' to el
 *                                                 // and if el has the class 'off', remove it
 *
 *     $(el).toggleClass('off', 'hilite');         // if el has the class 'off' then replace it with 'hilite'
 *                                                 // or if el has the class 'hilite' then replace it with 'off'
 *                                                 // does nothing if el has neither the class 'off' nor the class 'hilite'
 *
 *     $(el).toggleClass('off', 'hilite', true);   // as the previous example, but if el does not have the class 'off' nor 'hilite'
 *                                                 // then apply the class 'hilite'
 *
 *
 * @see http://snipplr.com/view/3338/toggle-classname/
 *
 */

(function($){
   $.fn.extend({

                 replaceClass : function(oldClass, newClass, addNewClassp) {

                   return this.each(
                     function() {

                       var el = $(this);

                       if (el.hasClass(oldClass) || addNewClassp === true) {

                         el.removeClass(oldClass);
                         el.addClass(newClass);

                       }

                     });
                 }
               });
 })(jQuery);


(function($){
   $.fn.extend({

                 toggleClass : function(oldClass, newClass, addNewClassp) {

                   var addp = addNewClassp || false;

                   return this.each(
                     function() {

                       var el = $(this);

                       if (el.hasClass(oldClass))
                         el.replaceClass(oldClass, newClass, addp);

                       else if (el.hasClass(newClass))
                       el.replaceClass(newClass, oldClass, addp);

                     });
                 }
               });
 })(jQuery);
