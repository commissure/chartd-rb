class Chartd
  B62 = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'.freeze

  def self.encode(dataset = [], min: nil, max: nil)
    return '' if dataset.empty?

    min ||= dataset.min
    max ||= dataset.max

    range = dim(max, min)
    return B62[0] * dataset.count if range == 0

    enclen = B62.length - 1
    encoded = dataset.map do |v|
      index = (enclen * (v - min) / range).to_i

      if index >= 0 && index < B62.length
        B62[index]
      else
        B62[0]
      end
    end

    encoded.join
  end

  # dim returns the maximum of x-y or 0.
  # It is used to calculate the range of the dataset.
  def self.dim(x, y)
    return 0 if x < y

    x - y
  end
  private_class_method :dim
end
