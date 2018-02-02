module Montague
  module XMLExtractor
    # Header extractor
    #
    class Header < Montague::XMLExtractor::Base

      def initialize(xml)
        super
      end

      # @return [String, nil]
      def api_control
        xpath_query_for_single_value(File.join header_path, 'apicontrol')
      end

      # @return [Fixnum, nil]
      def hits
        xpath_query_for_single_value(File.join header_path, 'numhits').to_i
      end

      # @return [String, nil]
      def message
        xpath_query_for_single_value(File.join header_path, 'message')
      end

      # @return [String, nil]
      def outcome
        xpath_query_for_single_value(File.join header_path, 'outcome')
      end

      # @return [Montague::Model::Header]
      def model
        m = Montague::Model::Header.new
        m.api_control = api_control
        m.hits = hits
        m.message = message
        m.outcome = outcome
        m
      end

    end
  end
end