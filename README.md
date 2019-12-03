For a [cooking website][3] I recently worked on,
I needed to display decimal floating point numbers as fractions. I needed to
come up with the fraction closest to what the user typed. For example, 0.33
should resolve to ⅓. When I googled for a solution, most of the code I found
was slow, buggy, and worst of all, too precise (returning 33/100 for the above example.)

<a class="bmc-button" target="_blank" href="https://www.buymeacoffee.com/clord"><img src="https://cdn.buymeacoffee.com/buttons/bmc-new-btn-logo.svg" alt="Buy me a coffee"><span style="margin-left:15px;font-size:19px !important;">Buy me a coffee</span></a>

I decided to widen my search to C, and [found][1] a piece of code on Stack Overflow
written by David Eppstein in 1993.
It uses the [theory of continued fractions][2] to approach the correct value,
but stops when the denominator reaches some value. The limitation of such an
algorithm is that we can't choose to leave out unnatural denominators

So became `fraction`: it's Eppstein's code in a Ruby gem.

Install it with `gem`:

    gem install fraction

Using this gem is easy:

    require 'fraction'
    num, den = 0.33.to_fraction   # num==1, den==3
    num, den = 0.33.fraction # legacy name also works

You can get the error:

    num,den,err = 0.33.to_fraction   #=> [1, 3, -0.0033333333333333]

you can choose a different maximum denominator than the default value of 10:

    num, den = 0.51.to_fraction(100) #=> [51, 100, 0.0]

There is also whole fraction support, which factors out any whole numbers:

    whole, num, den, error = 3.5.to_whole_fraction #=> [3, 1, 2, 0]

The best part of this gem over others is the speed:

    % ruby test.rb
    I'm Feeling Lucky: 19.145s
    'fraction' gem: 2.090s

subtracting the time required for an empty ruby loop, we can conclude the
algorithm itself requires only ½ of a second for 1,000,000 iterations on my Mac Pro.


[1]: http://stackoverflow.com/questions/95727/how-to-convert-floats-to-human-readable-fractions
[2]: http://www.maths.surrey.ac.uk/hosted-sites/R.Knott/Fibonacci/cfINTRO.html#termdecs
[3]: http://freshslowcooking.com
