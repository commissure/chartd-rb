# `chartd-rb` – Encode data for chartd.co

[![Build Status](https://travis-ci.org/commissure/chartd-rb.svg?branch=master)](https://travis-ci.org/commissure/chartd-rb)

:chart_with_upwards_trend: `chartd-rb` is a Ruby gem for [chartd.co],
a service from [@stathat], that allows you to creata a chart by encoding
a dataset into an URL, like so:

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

chart.url # => https://chartd.co/a.png?d0=Ae9…
```

### Y-Axis Minimum & Maximum

By default `chartd` uses the minimum and maximum values from your
dataset. They can be set explicitly like this:

```ruby
Chartd::Chart.new(data, min: 0, max: 100)
```

### Multiple Datasets

`data` can also be a multidimensional array, which will result in the
chart having multiple lines. The maximum of datasets to chart is 5.

Example:

```ruby
# grab some more data
data = [
  [1, 3, 2],
  [5, 3, 4]
]

# and create a chart
chart = Chartd::Chart.new(data)

chart.url # => https://chartd.co/a.png?d0=AeP&d1=9et…
```

### Width & Height

The default dimensions of a chart are `580px x 180px`. You can change
them using the `options` parameter:

```ruby
Chartd::Chart.new(data, options: { w: 2000, h: 1000 })
```

**:warning: Important:** chartd doubles the dimensions of the chart so
that the resulting image is `@2x`, meaning it looks great on retina
(high res) screens.

### Disabling Y-Axis Labels

The y-axis are both labeled by default. Set `ylabel` to `false` when
creating a chart to turn that off:

```ruby
Chartd::Chart.new(data, ylabels: false)
```

### Image Format

While chartd supports both `.svg` and `.png`, `chartd-rb` currently
only supports `.png`.

### Options

The `options` hash is written directly to the final URL, meaning
that [all parameters documented on chartd.co][chartd] can be used.
Example:

  [chartd]: https://chartd.co/

```ruby
Chartd::Chart.new(data, options: {
  t: 'My Awesome Chart',
  step: 1,
  hl: 1,
})
```

I would be happy to accept a PR that integrates some of them (for
example the coloring) a little bit more nicely.


## Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b your-feature`
3. Add your changes
4. Push changes: `git push -u origin your-feature`
5. Submit a pull request


## License

This project is licensed under the **MIT license**. See the `LICENSE`
file for details.
