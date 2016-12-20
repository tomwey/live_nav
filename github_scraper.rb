# coding: utf-8
require 'wombat'

class GithubScraper
  include Wombat::Crawler
  
  base_url "http://www.github.com"
  path "/"

  headline "xpath=//h1"

  benefits do
    team_mgmt "css=.column.leftmost h3"
    code_review "css=.column.leftmid h3"
    hosting "css=.column.rightmid h3"
    collaboration "css=.column.rightmost h3"
  end
  
end

puts GithubScraper.new.crawl