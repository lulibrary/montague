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
      # @return (see #journal_report)
      def find_by_issn(issn)
        url = "#{@config[:api_url]}?issn=#{issn}#{common_parameters}"
        response = HTTP.get URI.encode(url)
        journal_report response
      end

      # @param text [String] Multiple words treated as a single string. Case insensitive.
      # @param filter [Symbol]
      #   * :exact - Verbatim e.g. 'Journal of Geology'
      #   * :starts - Starts with e.g. 'machine'
      #   * :contains - Contains e.g. 'modern language'
      # @return (see #journals_report)
      def find_by_title(text:, filter: :exact)
        url = "#{@config[:api_url]}?jtitle=#{text}&qtype=#{filter}#{common_parameters}"
        client = HTTP::Client.new
        # client = client.headers({'Content-type' => 'text/xml; charset=ISO-8859-1'})
        # puts client.inspect
        response = client.get URI.encode(url)
        puts [ response.to_s.encoding, response.to_s.valid_encoding? ]
        # response = HTTP.get URI.encode(url)
        report = journals_report response
        puts report.publisher.romeo_colour
        # puts report.publisher.romeo_colour.encode('ISO-8859-1')
        journals_report response
      end

      private

      # @return [Montague::Model::JournalReport]
      def journal_report(response)
        xml_extractor = Montague::Reporter::Journal.new response
        xml_extractor.report
      end

      # @return [Montague::Model::JournalsReport]
      def journals_report(response)
        xml_extractor = Montague::Reporter::Journals.new response
        xml_extractor.report
      end

    end

  end

end