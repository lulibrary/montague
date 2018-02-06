module Montague

  module API

    # Publisher API
    #
    class Publisher < Montague::API::Base

      # (see Montague::API::Base#initialize)
      def initialize(config = {})
        super
      end

      # @param id [Fixnum] RoMEO persistent ID
      # @return (see #publisher_report)
      def find_by_id(id)
        url = "#{@config[:api_url]}?id=#{id}#{common_parameters}"
        response = HTTP.get URI.encode(url)
        publisher_report response
      end

      # @param text [String] e.g. 'optical society'
      # @param filter [Symbol]
      #   * :all - All words present but in any order or location
      #   * :any - At least one of the words present
      #   * :exact - Intact phrase somewhere e.g. 'tute of'
      # @return (see #publishers_report)
      def find_by_name(text:, filter: :all)
        url = "#{@config[:api_url]}?pub=#{text}&qtype=#{filter}#{common_parameters}"
        response = HTTP.get URI.encode(url)
        publishers_report response
      end

      private

      # @return [Montague::Model::PublishersReport]
      def publishers_report(response)
        xml_extractor = Montague::Reporter::Publishers.new response
        xml_extractor.report
      end

      # @return [Montague::Model::PublisherReport]
      def publisher_report(response)
        xml_extractor = Montague::Reporter::Publisher.new response
        xml_extractor.report
      end

    end

  end

end