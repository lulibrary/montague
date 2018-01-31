module Montague

  module API

    # Publisher API
    #
    class Publisher < Montague::API::Base

      # (see Montague::API::Base#initialize)
      def initialize(config = {})
        super
      end

      # @param id [Fixnum]
      # @return (see Montague::API::Base#report)
      def find_by_id(id)
        url = "#{@config[:api_url]}?id=#{id}#{common_parameters}"
        response = HTTP.get URI.encode(url)
        report response
      end

      # @param name [String] e.g. 'optical society'
      # @param query_type [Symbol]
      #   * :all - All words present but in any order or location
      #   * :any - At least one of the words present
      #   * :exact - Intact phrase somewhere e.g. 'tute of'
      # @return (see Montague::API::Base#report)
      def find_by_name(name:, query_type:)
        url = "#{@config[:api_url]}?pub=#{name}&qtype=#{query_type}#{common_parameters}"
        response = HTTP.get URI.encode(url)
        report response
      end

    end

  end

end