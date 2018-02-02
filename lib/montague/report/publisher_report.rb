module Montague
  module Report
    # Publisher report
    #
    class PublisherReport

      def initialize(response)
        @response = response
        @header_extractor = Montague::XMLExtractor::Header.new response.to_s
        @publisher_extractor = Montague::XMLExtractor::Publisher.new response.to_s
      end

      # @return [Montague::Model::PublisherReport]
      def report
        h = Montague::Model::PublisherReport.new
        h.http_response = @response
        h.header = @header_extractor.model
        h.publisher = @publisher_extractor.model
        h
      end

    end
  end
end
