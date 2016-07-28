# `chartd-rb` – Encode data for chartd.co

:warning: Work in progress.

[![Build Status](https://travis-ci.org/commissure/chartd-rb.svg?branch=master)](https://travis-ci.org/commissure/chartd-rb)

`chartd-rb` is a Ruby gem for [chartd.co], which is a service from
[@stathat], that allows you to creata a chart by encoding the dataset
into an URL, like so:

  [chartd.co]: https://chartd.co
  [@stathat]: https://github.com/stathat

```
https://chartd.co/a.png?w=580&h=180&d0=SRWfaZHLHEDABKKTUYgpqqvws0138eZfaYtwxxsxyst&ymin=94.48&ymax=103.3
```

The URL can then be used with a simple `<img>` tag and the resulting
chart looks like this:

<img src="https://chartd.co/a.png?w=580&h=180&d0=SRWfaZHLHEDABKKTUYgpqqvws0138eZfaYtwxxsxyst&ymin=94.48&ymax=103.3">

## Usage

```ruby
# grab some data
data = [1, 2, 3]

# and create a chart
chart = Chartd::Chart.new(data)

chart.url # => https://chartd.co/a.png?d0=Ae9
```
