require 'chartd/encoder'
require 'uri'

class Chartd
  BASE_URL = URI.parse('https://www.chartd.co/a.png')

  class Chart
    ERR_BAD_DATASET = 'Dataset has to be an array of Fixnums and/or Floats.'.freeze
    ERR_TOO_MANY_DATASETS = 'Too many datasets supplied, the maximum is 5.'.freeze

    attr_reader :dataset

    # allow min and max to be changed after instantiating a Chart
    attr_accessor :min, :max

    def initialize(dataset = [], min: nil, max: nil, ylabels: true, options: {})
      raise ERR_BAD_DATASET unless dataset.is_a?(Array)

      # Check if dataset is multidimensional and if so, use it as is.
      # Otherwise make it multidimensional.
      if dataset[0].is_a?(Array)
        raise ERR_TOO_MANY_DATASETS if dataset.count > 5
        @dataset = dataset
      else
        @dataset = [dataset]
      end

      # calculate min and max across the entire dataset but only if they are
      # not set explicitly.
      @min = min || dataset.flatten.min
      @max = max || dataset.flatten.max

      @ylabels = ylabels

      @options = default_options.merge(options)
    end

    def url
      u = BASE_URL.dup

      # encode each piece of data and append it to URL as params
      encoded_data = @dataset.each_with_index.map do |d, i|
        ["d#{i}", Encoder.encode(d, min: @min, max: @max)]
      end

      # set labels for y axis when they’re enabled (which they are by default)
      if @ylabels
        @options[:ymin] ||= @min
        @options[:ymax] ||= @max
      end

      u.query = URI.encode_www_form(
        @options.merge(encoded_data.to_h)
      )
      u.to_s.force_encoding('utf-8')
    end

    private

    # Default options for a chart URL, can be overridden when instantiating a
    # Chart using the options argument.
    def default_options
      { w: 580, h: 180 }
    end
  end
end
