# coding: utf-8
require 'wombat'

class RubyGemsScraper
  include Wombat::Crawler
  
  base_url "http://www.github.com"
  path "/"
  
  gems do |g|
    g.new "css=#new_gems li", :list
    g.most_downloaded "css=#most_downloaded li", :list
    g.just_updated "css=#just_updated li", :list
  end
end

p RubyGemsScraper.new.crawl