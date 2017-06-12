module Classifier
  class Error < StandardError; end
  class InvalidColumn < Error; end
  class NotEnoughData < Error; end
  class InvalidInput < Error; end
end
