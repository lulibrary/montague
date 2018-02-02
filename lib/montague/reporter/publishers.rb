module Montague
  module Reporter
    # Publishers reporter
    #
    class Publishers

      def initialize(response)
        @response = response
        @header_extractor = Montague::XMLExtractor::Header.new  response.to_s
        @publisher_extractor = Montague::XMLExtractor::Publisher.new  response.to_s
      end

      # @return [Montague::Model::PublishersReport]
      def report
        h = Montague::Model::PublishersReport.new
        h.http_response = @response
        h.header = @header_extractor.model
        h.publishers = @publisher_extractor.models
        h
      end

    end
  end
end
