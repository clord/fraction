/*
** find rational approximation to given real number
** David Eppstein / UC Irvine / 8 Aug 1993
**
** With corrections from Arno Formella, May 2008
**
** Made into a ruby module by Christopher Lord, Nov 2009
**
** usage: require 'findfract'
**
**        n,d,err = 0.33.fraction
**
** based on the theory of continued fractions
** if x = a1 + 1/(a2 + 1/(a3 + 1/(a4 + ...)))
** then best approximation is found by truncating this series
** (with some adjustments in the last term).
**
** Note the fraction can be recovered as the first column of the matrix
**  ( a1 1 ) ( a2 1 ) ( a3 1 ) ...
**  ( 1  0 ) ( 1  0 ) ( 1  0 )
** Instead of keeping the sequence of continued fraction terms,
** we just keep the last partial product of these matrices.
*/

#include "ruby.h"
#include <stdio.h>
VALUE method_html_form_for(VALUE self)
{
   VALUE res = rb_str_new2("<span class='fraction'><span class='above'>");
   // This is an array. to make a string form, we want to 
   VALUE num = rb_obj_as_string(rb_ary_entry(self, 0));
   VALUE den = rb_obj_as_string(rb_ary_entry(self, 1));
   rb_str_concat(res, rb_obj_as_string(num));
   rb_str_cat2(res, "</span>&#8260;<span class='below'>");
   rb_str_concat(res, rb_obj_as_string(den));
   rb_str_cat2(res, "</span></span>");
   // CSS for the above html (From http://www.cs.tut.fi/~jkorpela/math/#fractions)
   // .above, .below { font-size: 70%;
   //                  font-family: Verdana, Arial, sans-serif; }
   // .above { vertical-align: 0.7ex; }
   // .below { vertical-align: -0.3ex; }
   return res;   
}
VALUE method_string_form_for(VALUE self)
{
   VALUE res = rb_str_new2("");
   // This is an array. to make a string form, we want to 
   VALUE num = rb_obj_as_string(rb_ary_entry(self, 0));
   VALUE den = rb_obj_as_string(rb_ary_entry(self, 1));
   rb_str_concat(res, rb_obj_as_string(num));
   rb_str_cat2(res, "/");
   rb_str_concat(res, rb_obj_as_string(den));
   return res;   
}
VALUE method_fraction_for(int argc, VALUE * argv, VALUE self)
{
   long m11, m12,
        m21, m22;
   VALUE res = rb_ary_new2(3);
   VALUE maxdenr;
   int maxden = 10; // the default
   rb_scan_args(argc, argv, "01", &maxdenr);
   if (!NIL_P(maxdenr))
     maxden = NUM2INT(maxdenr);
   int ai;
   double x = NUM2DBL(self);
   double startx = x;
   m11 = m22 = 1;
   m12 = m21 = 0;

   // loop finding terms until denom gets too big
   while (m21 *  ( ai = (long)x ) + m22 <= maxden) {
      long t = m11 * ai + m12;
      m12 = m11;
      m11 = t;
      t = m21 * ai + m22;
      m22 = m21;
      m21 = t;
      if(x==(double)ai) break;
      x = 1/(x - (double) ai);
      if(x>(double)0x7FFFFFFF) break;
   }
   VALUE numer1 = INT2NUM(m11);
   VALUE denom1 = INT2NUM(m21);
   VALUE err1 = rb_float_new(startx - ((double) m11 / (double) m21));
   rb_ary_store(res, 0, numer1);
   rb_ary_store(res, 1, denom1);
   rb_ary_store(res, 2, err1);
// Although the below is very cool, it's also quite slow to execute. 
  // rb_define_singleton_method(res, "to_s", method_string_form_for, 0);
  // rb_define_singleton_method(res, "to_html", method_html_form_for, 0);


   /* We can go one more step to find another candidate:
      m11 = m11 * ai + m12;
      m21 = m21 * ai + m22;
      m11/m21, err= startx - ((double) m11 / (double) m21))
   */
   return res;
}

void Init_fraction() {
   rb_define_method(rb_cNumeric, "fraction", method_fraction_for, -1);
   rb_define_method(rb_cFloat,   "fraction", method_fraction_for, -1);
}

