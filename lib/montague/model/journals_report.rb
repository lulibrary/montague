module Montague
  module Model
    # Journals report
    #
    class JournalsReport
      include Montague::Model::ReportHTTPResponseMixin
      include Montague::Model::ReportHeaderMixin

      # @return [Array<Montague::Model::Journal>]
      attr_accessor :journals

      # Present only when #journals size is 1
      # @return [Montague::Model::Publisher, nil]
      attr_accessor :publisher

    end
  end
end