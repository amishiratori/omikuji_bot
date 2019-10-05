require 'bundler/setup'
Bundler.require
# require 'sinatra/reloader' if development?
require 'dotenv'
require 'line/bot'
require './random_index'

before do
  Dotenv.load
  def client
    @client ||= Line::Bot::Client.new { |config|
        config.channel_secret = ENV['LINE_CHANNEL_SECRET']
        config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    }
  end
end

post '/message' do
  body = request.body.read
  signature = request.env['HTTP_X_LINE_SIGNATURE']
  unless client.validate_signature(body, signature)
    error 400 do 'Bad Request' end
  end
  events = client.parse_events_from(body)
  events.each do |event|
      case event
          when Line::Bot::Event::Message
              case event.type
                  when Line::Bot::Event::MessageType::Text
                    content = event.message['text']
                    if content == 'おみくじ'
                      image = RandomIndex.get_omikuji()
                      message = {
                          type: 'image',
                          originalContentUrl: image,
                          previewImageUrl: image
                      }
                    else
                      response_message = '「おみくじ」と送信すると、おみくじが引けるよ！'
                      message = {
                        type: 'text',
                        text: response_message
                      }
                    end
                    client.reply_message(event['replyToken'], message)
                    break
                  else
                    response_message = '「おみくじ」と送信すると、おみくじが引けるよ！'
                      message = {
                        type: 'text',
                        text: response_message
                      }
                    client.reply_message(event['replyToken'], message)
          end
        end
  end
end