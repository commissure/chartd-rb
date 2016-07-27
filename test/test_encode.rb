require 'test/unit'
require 'chartd'

class Chartd::EncodeTest < Test::Unit::TestCase
  def test_encode
    testcases = [
      [[1.2, 2.4, 3.1], 'Am9'],
      [[40, 50, 33.2], 'Y8A'],
      [[0, 9, 9], 'A99'],
      [[0.944, 0.170, 0.201, 0.839, 0.284, 0.485, 0.154, 0.431, 0.119, 0.679], '9DG1MbCXAp'],
      [[0, -2, 9], 'LA9'],
      [[0], 'A'],
      [[], ''],
    ]

    testcases.each do |d, expected|
      assert_equal expected, Chartd::Encoder.encode(d)
    end
  end

  def test_encode_custom_min_max
    testcases = {
      'Ueo' => [[20, 30, 40], 0, 60],
      'Ae9' => [[20, 30, 40], 20, 40],
    }

    testcases.each do |expected, data|
      assert_equal expected, Chartd::Encoder.encode(data[0], min: data[1], max: data[2])
    end
  end

  def test_encode_helper
    assert_equal Chartd::Encoder.encode([1, 2, 3]), Chartd.encode([1, 2, 3])
  end
end
