module Montague
  module Model
    # Journal report
    #
    class JournalReport
      include Montague::Model::ReportHeaderMixin
      include Montague::Model::ReportHTTPResponseMixin
      include Montague::Model::ReportPublisherMixin

      # @return [Montague::Model::Journal, cd nil]
      attr_accessor :journal

    end
  end
end