module Montague

  module API

    # API client
    #
    class Client < Montague::API::Base
      # (see Montague::API::Base#initialize)
      def initialize(config = {})
        super
      end

      # @return [Montague::API::Journal]
      def journals
        Montague::API::Journal.new @config
      end

      # @return [Montague::API::Publisher]
      def publishers
        Montague::API::Publisher.new @config
      end

    end

  end

end