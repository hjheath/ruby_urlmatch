module Urlmatch
  class Error < StandardError
  end


  def self.urlmatch(pattern, url)
    # (scheme)://(domain)/(path)
    regex = /\A(\*|https|http):\/\/(\*|\*\.[^\*\/]+|[^\*\/]+)\/(.*)\z/
    @@pattern_match = regex.match(pattern)
    raise Error, "Invalid Match Pattern: #{pattern}" unless @@pattern_match
    url_regex = /\A#{scheme}:\/\/#{domain}\/#{path}\z/
    !!url_regex.match(url)
  end

  private

  def self.scheme
    scheme_pattern = @@pattern_match[1]
    scheme_pattern == '*' ? /https?/ : scheme_pattern
  end

  def self.domain
    domain_pattern = @@pattern_match[2]
    return (/#{Regexp.quote(domain_pattern)}/) unless domain_pattern.start_with?('*')
    return (/[^\/]+/) if domain_pattern == '*'
    non_wild_domain = domain_pattern[2..-1]
    /([^\/]+\.)?#{Regexp.quote(non_wild_domain)}/
  end

  def self.path
    path_pattern = @@pattern_match[3]
    path_pattern.sub('*', '.*')
  end
end
