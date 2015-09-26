module Destiny
  class Error < StandardError; end
  class HTTPError < Error; end
  class PlatformError < Error; end
  class HTTPToManyRedirects < Error; end
end
