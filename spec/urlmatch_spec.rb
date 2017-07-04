require 'spec_helper'

describe Urlmatch do
  http_url = 'http://test.com/'
  https_url = 'https://test.com/'
  subdomain_url = 'http://subdomain.test.com/'

  it 'raises on invalid scheme' do
    pattern = 'bad://test.com/*'
    expect { Urlmatch.urlmatch(pattern, http_url) }.to raise_error Urlmatch::Error

    pattern = 'http:/test.com/*'
    expect { Urlmatch.urlmatch(pattern, http_url) }.to raise_error Urlmatch::Error
  end

  it 'raises on invalid domain' do
    pattern = 'http:///*'
    expect { Urlmatch.urlmatch(pattern, http_url) }.to raise_error Urlmatch::Error

    pattern = 'http://*test/*'
    expect { Urlmatch.urlmatch(pattern, http_url) }.to raise_error Urlmatch::Error

    pattern = 'http://sub.*.test/*'
    expect { Urlmatch.urlmatch(pattern, http_url) }.to raise_error Urlmatch::Error
  end

  it 'raises on invalid path' do
    pattern = 'http://test.com'
    expect { Urlmatch.urlmatch(pattern, http_url) }.to raise_error Urlmatch::Error
  end

  it 'always matches with a full wildcard' do
    pattern = "*://*/*"
    expect( Urlmatch.urlmatch(pattern, http_url) ).to equal true
    expect( Urlmatch.urlmatch(pattern, https_url) ).to equal true
    expect( Urlmatch.urlmatch(pattern, subdomain_url) ).to equal true
    expect( Urlmatch.urlmatch(pattern, 'http://other.com/') ).to equal true
  end

  it 'matches an exact pattern' do
    pattern = "http://test.com/exact/path"
    expect( Urlmatch.urlmatch(pattern, pattern) ).to equal true
    expect( Urlmatch.urlmatch(pattern, 'http://test.com/inexact/path') ).to equal false
    expect( Urlmatch.urlmatch(pattern, 'http://badtest.com/exact/path') ).to equal false
  end

  it 'matches http scheme' do
    pattern = 'http://test.com/*'
    expect( Urlmatch.urlmatch(pattern, http_url) ).to equal true
    expect( Urlmatch.urlmatch(pattern, https_url) ).to equal false
    expect( Urlmatch.urlmatch(pattern, subdomain_url) ).to equal false
  end

  it 'matches https scheme' do
    pattern = 'https://test.com/*'
    expect( Urlmatch.urlmatch(pattern, http_url) ).to equal false
    expect( Urlmatch.urlmatch(pattern, https_url) ).to equal true
    expect( Urlmatch.urlmatch(pattern, subdomain_url) ).to equal false
  end

  it 'matches wildcard scheme' do
    pattern = '*://test.com/*'
    expect( Urlmatch.urlmatch(pattern, http_url) ).to equal true
    expect( Urlmatch.urlmatch(pattern, https_url) ).to equal true
    expect( Urlmatch.urlmatch(pattern, subdomain_url) ).to equal false
  end

  it 'matches wildcard subdomains' do
    pattern = 'http://*.test.com/*'
    expect( Urlmatch.urlmatch(pattern, http_url) ).to equal true
    expect( Urlmatch.urlmatch(pattern, subdomain_url) ).to equal true
    expect( Urlmatch.urlmatch(pattern, 'http://such.subdomain.test.com/') ).to equal true
    expect( Urlmatch.urlmatch(pattern, 'http://wow.such.subdomain.test.com/') ).to equal true
  end

  it 'matches sub subdomains' do
    pattern = 'http://*.subdomain.test.com/*'
    expect( Urlmatch.urlmatch(pattern, http_url) ).to equal false
    expect( Urlmatch.urlmatch(pattern, subdomain_url) ).to equal true
    expect( Urlmatch.urlmatch(pattern, 'http://such.subdomain.test.com/') ).to equal true
    expect( Urlmatch.urlmatch(pattern, 'http://wow.such.subdomain.test.com/') ).to equal true
  end
end
