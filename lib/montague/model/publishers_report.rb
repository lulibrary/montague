module Montague
  module Model
    # Publishers report
    #
    class PublishersReport
      include Montague::Model::ReportHTTPResponseMixin
      include Montague::Model::ReportHeaderMixin

      # @return [Array<Montague::Model::Publisher>]
      attr_accessor :publishers

    end
  end
end