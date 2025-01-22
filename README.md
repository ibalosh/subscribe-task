# Subscribe task

The repository contains a solution to the challenge described in the `challenge.md` file.

## Implementation details

The following was used to implement the solution:

* Ruby  (version is provided in the `.ruby-version` file)
* RSpec (version is provided in the `Gemfile`)
* SimpleCov - just to check the test coverage, not needed for solution though

## Running the tests and trying out the solution

Before running the tests, and trying out the solution, make sure to install ruby, and gems with the bundler.
Since I use rvm, all I did was the following:

```bash
  rvm install $(cat .ruby-version)
  rvm use
  bundle install
```

In case you are not using rvm, install [ruby by checking docs](https://www.ruby-lang.org/en/documentation/installation/), and then run `bundle install` in the terminal.

In order to verify the solution, you can run then the tests by executing `bundle exec rspec` in the terminal, at root of the project.

You can also play around with the solution by running: (feel free to check out the file for examples I used)

```ruby
  bundle exec ruby lib/playground.rb
```

After running that command, you should see results, which follow the examples provided in the challenge.

```ruby
Receipt:
2 book: 24.98
1 music: 16.49
1 chocolate: 0.85
Sales Taxes: 1.50
Total: 42.32

Receipt:
1 chocolate: 10.50
1 perfume: 54.65
Sales Taxes: 7.65
Total: 65.15

Receipt:
1 perfume: 32.19
1 perfume: 20.89
1 headache pills: 9.75
3 chocolate: 35.55
Sales Taxes: 7.90
Total: 98.38
```

If you would like to try out the solution in similar way as in the challenge examples, you can run the following:

```ruby
  bundle exec ruby lib/playground_with_input.rb
```

For each item you will be prompted to enter the quantity, product name, price, optionally type, and whether it's imported.
Once you finish entering the items, you can type `done` to get the receipt.

An example of input and output can be seen below:

```shell
Enter item (or write 'done' to finish): 1 bottle of perfume at 27.99 other imported
Added: 1 bottle of perfume at 27.99
Enter item (or write 'done' to finish): 1 bottle of perfume at 18.99 other
Added: 1 bottle of perfume at 18.99
Enter item (or write 'done' to finish): 1 packet of headache pills at 9.75 medical
Added: 1 packet of headache pills at 9.75
Enter item (or write 'done' to finish): 3 boxes of chocolates at 11.25 food imported
Added: 3 boxes of chocolates at 11.25
Enter item (or write 'done' to finish): done

Receipt:
1 bottle of perfume: 32.19
1 bottle of perfume: 20.89
1 packet of headache pills: 9.75
3 boxes of chocolates: 35.55
Sales Taxes: 7.90
Total: 98.38
```

### Solution

The solution is implemented in the `lib/calculator` folder. Within `lib` you will also find files which allow you to
play around with the solution, with either providing input, or just objects - products. 
Details how to run the app were provided earlier.

When creating a receipt, for each product, taxes are calculated and total cost and taxes are stored.
This data can be output with formatter for the receipt.

### What can be improved

The solution can be improved in the following ways:

1. Parsing within input handler is very basic. I went for simplest solution which easily parses the input, by providing:

`quantity`, `name`, `base price`, `type`, `imported` keyword. 

I did not go too far in validating the input. Also, the type is provided within input. 
We do not auto determine product based on the name. I made an assumption here that product type can be provided.

2. We parse only one input, and print one receipt. We can improve it to show multiple receipt until we want to stop the app.

