# advantager
Seeking to gain advantage by overcoming challenges


Line of credit:
--------------------------------------------------
A hash of arrays with key representing the month
is created at initialization.

Inside spec for ‘monthly_payment’, I run thru
Scenario 1 and Scenario 2. 

Each transactions are store internally as a Line
item. When ’monthly_interest’ is called, it will 
loop thru all the transactions for that month
and calculate interest for that transaction. 
Each interest amount is based on the ‘term’ and
‘principle’.

Balance is initialized as 0 and is calculated per
each withdraw and deposit. ‘monthly_payment’ is 
the sum of current balance and ‘monthly_interest’.



Factor/Multiplier and cache:
--------------------------------------------------
factors function will find factors in the given 
array and collect factors of each element recursively


multipliers function will find multipliers in the given 
array and collect multipliers of each element recursively

My idea of caching is to store result of an given input
array as yaml file inside some specific directory.

For instance, given an input array of [10, 5, 2, 20]
will create cache file ‘2-5-10-20.yml’ inside
‘/data/factors/’

Similar operation is done multiplier type operation.

So the performance is based on the ability to loop thru
files inside the directory. At the same time, the directory
size in the file system would be constraint.

I chosed to create the filename using a sorted array to 
avoid creating different cache files for the same input
arrays. i.e. ‘[10, 5, 2, 20]’ and ‘[5, 10, 2, 20]’ As a 
result, the file would be overwritten. 

At initialization of Berth.new two arrays of string will
represent all the cache available. For given input calculation
new file would be generated as well as updating the arrays.
