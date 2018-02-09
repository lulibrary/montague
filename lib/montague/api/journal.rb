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
        response = HTTP.get URI.encode(url)
        journals_report response
      end

      private

      # @return [Montague::Model::JournalReport]
      def journal_report(response)
        reporter = Montague::Reporter::Journal.new response
        reporter.report
      end

      # @return [Montague::Model::JournalsReport]
      def journals_report(response)
        reporter = Montague::Reporter::Journals.new response
        reporter.report
      end

    end

  end

end