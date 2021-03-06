module Montague
  module Model
    # Publisher report
    #
    class PublisherReport
      include Montague::Model::ReportHeaderMixin
      include Montague::Model::ReportHTTPResponseMixin
      include Montague::Model::ReportPublisherMixin

    end
  end
end