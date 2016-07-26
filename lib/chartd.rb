class Chartd
  B64 = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'.freeze

  def self.encode(values = [])
    return '' if values.empty?

    encoded = []
    min = values.min
    max = values.max

    r = dim(max, min)

    if r == 0
      values.count.times { encoded << B64[0] }
      return encoded.join('')
    end

    enclen = B64.length - 1

    values.each do |v|
      index = (enclen * (v - min) / r).to_i

      if index >= 0 && index < B64.length
        encoded << B64[index]
        next
      end

      encoded << B64[0]
    end

    encoded.join('')
  end

  def self.dim(x, y)
    return 0 if x < y

    x - y
  end
  private_class_method :dim
end
