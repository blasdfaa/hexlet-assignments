# frozen_string_literal: true
require 'uri'

# BEGIN
class Url
  attr_accessor :scheme, :host, :query_params, :port

  include Comparable

  def <=>(other)
    [port, scheme, host, query_params.sort] <=> [other.port, other.scheme, other.host, other.query_params.sort]
  end

  def initialize(url)
    parsed = URI(url)
    @scheme = parsed.scheme
    @host = parsed.host
    @port = parsed.port
    @query_params = parse_query(parsed.query || '')
  end

  def query_param(key, default_value = nil)
    query_params[key] ||= default_value
  end

  private

  def parse_query(query_string)
    query_string.split('&').each_with_object({}) do |pair, acc|
      key, value = pair.split('=')
      acc[key.to_sym] = value
    end
  end
end
# END
