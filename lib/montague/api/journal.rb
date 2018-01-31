module Montague

  module API

    # Journal API
    #
    class Journal < Montague::API::Base

      # (see Montague::API::Base#initialize)
      def initialize(config = {})
        super
      end

      # @param issn [String] International Standard Serial Number e.g. 1234-5678.
      # @return (see Montague::API::Base#report)
      def find_by_issn(issn)
        url = "#{@config[:api_url]}?issn=#{issn}#{common_parameters}"
        response = HTTP.get URI.encode(url)
        report response
      end

      # @param title [String] Multiple words treated as a single string
      # @param query_type [Symbol]
      #   * :contains - Partial title e.g. 'modern language'
      #   * :starts - Partial title e.g. 'Machine'
      #   * :exact - Title e.g. 'Journal of Geology'
      # @return (see Montague::API::Base#report)
      def find_by_title(title:, query_type:)
        url = "#{@config[:api_url]}?jtitle=#{title}&qtype=#{query_type}#{common_parameters}"
        response = HTTP.get URI.encode(url)
        report response
      end

    end

  end

end