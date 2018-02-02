module Montague
  module Model
    # Report HTTP response mixin
    #
    module ReportHTTPResponseMixin

      # @return [HTTP::Response]
      attr_accessor :http_response

    end
  end
end