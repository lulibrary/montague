module Montague
  module Model
    # Publishers report
    #
    class PublishersReport
      include Montague::Model::ReportHeaderMixin
      include Montague::Model::ReportHTTPResponseMixin

      # @return [Array<Montague::Model::Publisher>]
      attr_accessor :publishers

    end
  end
end