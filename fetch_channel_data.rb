# coding: utf-8
require 'wombat'

class ChannelDataScraper
  include Wombat::Crawler
  
  base_url "http://m.tvmao.com"
  # path "/program/CCTV-CCTV1-w1.html"
  
  playlists "css=table.timetable tr", :iterator do
    name 'css=a'
    time 'css=div.pb10'
  end
end

crawler = ChannelDataScraper.new
page = crawler.mechanize.get('http://m.tvmao.com/program/CCTV-CCTV1-w1.html')
crawler.metadata[:page] = page
p crawler.crawl