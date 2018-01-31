module Montague
  module Model
    # Header
    #
    class Header

      # @return [String, nil]
      attr_accessor :api_control

      # @return [Fixnum, nil]
      attr_accessor :hits

      # @return [String, nil]
      attr_accessor :message

      # @return [String, nil]
      attr_accessor :outcome

    end

  end
end