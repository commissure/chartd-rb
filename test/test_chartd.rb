require 'test/unit'
require 'chartd'

class ChartdTest < Test::Unit::TestCase
  def test_encode
    testcases = [
      [[1.2, 2.4, 3.1], 'Am9'],
      [[40, 50, 33.2], 'Y8A'],
      [[0, 9, 9], 'A99'],
      [[0.944, 0.170, 0.201, 0.839, 0.284, 0.485, 0.154, 0.431, 0.119, 0.679], '9DG1MbCXAp'],
      [[0, -2, 9], 'LA9'],
    ]

    testcases.each do |d, expected|
      assert_equal expected, Chartd.encode(d)
    end
  end

  def test_empty_values
    assert_equal '', Chartd.encode
  end
end
