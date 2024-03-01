class UpdateQuotesJob < ApplicationJob
   
    def perform
       Quote.distinct(:tags).each do |tag|
         QuotesCrawlerService.call(tag)
       end
    end
end
   