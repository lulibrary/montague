module Montague
  module Model
    # Publisher report
    #
    class PublisherReport

      # @return [Montague::Model::Journal]
      attr_accessor :journal

      # @return [Montague::Model::Publisher]
      attr_accessor :publisher
    end
  end
end