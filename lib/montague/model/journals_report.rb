module Montague
  module Model
    # Journals report
    #
    class JournalsReport
      include Montague::Model::ReportHeaderMixin
      include Montague::Model::ReportHTTPResponseMixin

      # @return [Array<Montague::Model::Journal>]
      attr_accessor :journals

    end
  end
end