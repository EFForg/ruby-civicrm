module CiviCrm
  module Errors
    class Unauthorized < RuntimeError; end
    class InternalError < RuntimeError; end
    class Forbidden < RuntimeError; end
    class BadRequest < RuntimeError; end
    class NotFound < RuntimeError; end
  end
end