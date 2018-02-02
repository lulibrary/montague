module Montague
  module Model
    # Publisher report
    #
    class PublisherReport
      include Montague::Model::ReportHTTPResponseMixin
      include Montague::Model::ReportHeaderMixin

      # @return [Montague::Model::Publisher]
      attr_accessor :publisher

    end
  end
end