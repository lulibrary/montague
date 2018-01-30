module Montague
  module XMLExtractor
    # Base XML extractor
    #
    class Base

      def initialize(xml)
         make_doc xml
      end

      # @return [Fixnum, nil]
      def hits
        xpath_query_for_single_value(File.join header_path, 'numhits').to_i
      end

      # @return [String, nil]
      def message
        xpath_query_for_single_value(File.join header_path, 'message')
      end

      private

      def make_doc(xml)
        xml = xml.encode('UTF-8', :invalid => :replace, :undef => :replace)
        @doc = Nokogiri::XML xml
        @doc.remove_namespaces!
      end

      # XPath search for a single value, at a given path.
      #
      # @return [String, nil]
      def xpath_query_for_single_value(path)
        xpath_result = @doc.xpath(path).text.strip
        xpath_result.empty? ? nil : xpath_result
      end

      # XPath search for multiple values, at a given path.
      #
      # @return [Array<String>]
      def xpath_query_for_multi_value(path)
        xpath_result = @doc.xpath path
        arr = []
        xpath_result.each { |i| arr << i.text.strip }
        arr.uniq
      end

      def xpath_query(path)
        @doc.xpath path
      end

      def root_path
        '/romeoapi'
      end

      def header_path
        File.join root_path, 'header'
      end

      def journal_path
        File.join root_path, 'journals/journal'
      end

      def publisher_path
        File.join root_path, 'publishers/publisher'
      end

      def hits_path
        File.join header_path, 'numhits'
      end

    end
  end
end