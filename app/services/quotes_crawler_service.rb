require 'nokogiri'
require 'open-uri'

class QuotesCrawlerService
 def self.call(tag)
    
    existing_quotes = Quote.where(tags: tag)
    return existing_quotes unless existing_quotes.empty?

    url = "https://quotes.toscrape.com/tag/#{tag}/"
    doc = Nokogiri::HTML(URI.open(url))
    quotes = doc.css('.quote')

    quotes.each do |quote|
      text = quote.css('.text').text
      author = quote.css('.author').text
      base_url = "https://quotes.toscrape.com"
      author_about = "#{base_url}#{quote.css('.author + a').attr('href').value}"

      tags = quote.css('.tag').map(&:text)

      existing_quote = Quote.where(quote: text, author: author, author_about: author_about, tags: tags).first
      unless existing_quote
        Quote.create(quote: text, author: author, author_about: author_about, tags: tags)
      end
    end

    
    Quote.where(tags: tag)
 end
end
