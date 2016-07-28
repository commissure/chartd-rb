require_relative 'test_helper'

require 'test/unit'
require 'chartd'

class ChartdTest < Test::Unit::TestCase
  def test_chart
    expected = 'https://chartd.co/a.png?w=580&h=180&ymin=1.2&ymax=3.1&d0=Am9'
    chart = Chartd::Chart.new([1.2, 2.4, 3.1])

    assert_equal expected, chart.url
  end

  def test_chart_multiline
    testdata = {
      'https://chartd.co/a.png?w=580&h=180&ymin=0.17&ymax=3.1&d0=Vu9&d1=QAI' => [
        [1.2, 2.4, 3.1],
        [0.944, 0.170, 0.601],
      ],
      'https://chartd.co/a.png?w=580&h=180&ymin=1&ymax=5&d0=AeP&d1=9et' => [
        [1, 3, 2],
        [5, 3, 4],
      ],
    }

    testdata.each do |expected, dataset|
      chart = Chartd::Chart.new(dataset)
      assert_equal expected, chart.url
    end
  end

  def test_chart_multiline_custom_min_max
    testdata = {
      'https://chartd.co/a.png?w=580&h=180&ymin=0&ymax=4&d0=Skv&d1=OCJ' => {
        dataset: [
          [1.2, 2.4, 3.1],
          [0.944, 0.170, 0.601],
        ],
        min: 0,
        max: 4,
      },
      'https://chartd.co/a.png?w=580&h=180&ymin=0&ymax=6&d0=KeU&d1=yeo' => {
        dataset: [
          [1, 3, 2],
          [5, 3, 4],
        ],
        min: 0,
        max: 6,
      },
    }

    testdata.each do |expected, data|
      chart = Chartd::Chart.new(
        data[:dataset],
        min: data[:min],
        max: data[:max]
      )
      assert_equal expected, chart.url
    end
  end

  def test_normalize_datasets
    assert_equal [[1, 2, 3]], Chartd::Chart.new([1, 2, 3]).dataset
    assert_equal [[2, 3], [3, 4]], Chartd::Chart.new([[2, 3], [3, 4]]).dataset
  end

  def test_min_max_accessors
    dataset = [1, 2, 3]

    regular = Chartd::Chart.new(dataset, min: 0, max: 5)

    with_accessors = Chartd::Chart.new(dataset)
    with_accessors.min = 0
    with_accessors.max = 5

    assert_equal regular.url, with_accessors.url
  end

  def test_raise_on_bad_dataset
    assert_raise do
      Chartd::Chart.new('foo bar')
    end

    assert_raise do
      # a maximum of 5 datasets is supported by chartd
      Chartd::Chart.new([[1], [1], [1], [1], [1], [1]])
    end
  end

  def test_disable_y_labels
    url = Chartd::Chart.new([1, 2, 3], ylabels: false).url
    assert_no_match %r{ymin=}, url
    assert_no_match %r{ymax=}, url
  end

  def test_options
    options = {
      t: 'Awesome Chart',
      step: 1,
      foo: 'bar',
    }

    url = Chartd::Chart.new([1, 2, 3], options: options).url
    assert_match %r{t=Awesome\+Chart}, url
    assert_match %r{step=1}, url
    assert_match %r{foo=bar}, url
  end
end
