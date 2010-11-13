For a [cooking website](http://freshslowcooking.com) I recently worked on, 
I needed to display decimal floating point numbers as fractions. I needed to 
come up with the fraction closest to what the user typed. For example, 0.33 
should resolve to ⅓. When I googled for a solution, most of the code I found 
was slow, buggy, and worst of all, too precise (returning 33/100 for the above example.)

I decided to widen my search to C, and found a piece of code on Stack Overflow 
written by David Eppstein in 1993. 
It uses the [theory of continued fractions][1] to approach the correct value, 
but stops when the denominator reaches some value. The limitation of such an 
algorithm is that we can't choose to leave out unnatural denominators 

So became `fraction`: it's Eppstein's code in a Ruby gem.

Install it with `gem`:

    gem install fraction

Using this gem is easy:

    require 'fraction'
    num, den = 0.33.fraction   # num==1, den==3

You can also get the error

    num,den,err = 0.33.fraction   #=> [1, 3, -0.0033333333333333]

you can choose a different maximum denominator than the default value of 10:
 
    num, den = 0.51.fraction(100) #[51, 100, 0.0]


The best part of this gem over others is the speed:

    % ruby test.rb 
    I'm Feeling Lucky: 19.145s
    'fraction' gem: 2.090s

subtracting the time required for an empty ruby loop, we can conclude the 
algorithm itself requires only ½ of a second for 1,000,000 iterations on my Mac Pro.


[1]: http://www.maths.surrey.ac.uk/hosted-sites/R.Knott/Fibonacci/cfINTRO.html#termdecs
