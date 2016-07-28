require 'test/unit'
require 'chartd'

class ChartdTest < Test::Unit::TestCase
  def test_chart
    expected = 'https://chartd.co/a.svg?w=580&h=180&d0=Am9'
    chart = Chartd::Chart.new([1.2, 2.4, 3.1])

    assert_equal expected, chart.url
  end

  def test_chart_multiline
    expected = 'https://chartd.co/a.svg?w=580&h=180&d0=Am9&d1=8AC'
    chart = Chartd::Chart.new(
      [
        [1.2, 2.4, 3.1],
        [0.944, 0.170, 0.201],
      ]
    )

    assert_equal expected, chart.url
  end

  def test_multiple_datasets
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
end
