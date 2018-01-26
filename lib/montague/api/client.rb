module Montague

  module API

    # API client
    #
    class Client < Montague::API::Base
      # (see Montague::API::Base#initialize)
      def initialize(config = {})
        super
      end

      # @return [Montague::API::PublisherReport]
      def journals
        Montague::API::Journal.new @config
      end

    end

  end

end