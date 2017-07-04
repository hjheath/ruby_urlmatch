urlmatch - fnmatch for the web
========

This is a Ruby port of Jesse Pollak's Python [urlmatch](https://github.com/jessepollak/urlmatch).

Use `urlmatch` to verify that URLs conform to certain patterns. The library and match patterns are based heavily on the [Google Chrome Extension match patterns](http://developer.chrome.com/extensions/match_patterns).

## Usage

```ruby
require 'urlmatch'

match_pattern = 'http://*.example.com/*'

Urlmatch.urlmatch(match_pattern, 'http://subdomain.example.com/') # true
Urlmatch.urlmatch(match_pattern, 'http://sub.subdomain.example.com/') # true

Urlmatch.urlmatch(match_pattern, 'https://example.com/') # false
Urlmatch.urlmatch(match_pattern, 'http://bad.com/') # false
```

## Match pattern syntax

The basic match pattern syntax is simple:

```
<url-pattern> := <scheme>://<host><path>
<scheme> := '*' | 'http' | 'https'
<host> := '*' | '*.' <any char except '/' and '*'>+
<path> := '/' <any chars>
```

### Examples

* `http://*/*` - matches any URL that uses the http scheme
* `https://*/*` - matches any URL that uses the https scheme
* `http://*/test*` - matches any URL that uses the http scheme and has a path that starts with `test`
* `*://test.com/*` - matches any url with the domain `test.com`
* `http://*.test.com` - matches `test.com` and any subdomain of `test.com`
* `http://test.com/foo/bar.html` - matches the exact URL


Bugs
----

If you find an issue, let me know in the issues section!
