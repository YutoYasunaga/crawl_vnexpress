class Article < ApplicationRecord

  # Function cập nhật tin tức mới
  def self.reload
    # Xóa tất cả các tin tức cũ
    delete_all

    # Khai báo thư viện cần thiết
    require 'open-uri'

    # Mở trang web
    website = Nokogiri::HTML(open("http://vnexpress.net/"))
    
    # Lấy link của 10 bài viết mới nhất
    articles = website.css('a.txt_link').first(10).map { |a| a['href'] }.compact.uniq
    
    # Vào từng link, lấy các giá trị cần thiết và tạo record
    articles.each do |article|
      page = Nokogiri::HTML(open(article))
      create(
        title: page.css('h1').text.gsub(/\s+/, ' '),
        short_intro: page.css('.short_intro').text,
        content: page.css('.fck_detail').text
      )
    end
  end
end
