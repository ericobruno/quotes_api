module Api
    class QuotesController < ApplicationController
        before_action :authenticate_request

        def show
            tag = params[:tag]
            QuotesCrawlerService.call(tag)
            quotes = Quote.where(tags: tag)

            if quotes.empty?
                render json: { error: 'Nenhuma frase encontrada para a tag fornecida' }, status: :not_found
            else
                render json: { quotes: quotes.as_json(only: [:quote, :author, :author_about, :tags]) }
            end
        end

        def authenticate_request
            auth_header = request.headers['Authorization']
            if auth_header.nil? || auth_header != Rails.application.config.api_token
                render json: { error: 'Unauthorized' }, status: 401
            end
        end
        
    end
    
end
   