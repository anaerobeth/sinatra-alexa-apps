require 'sinatra'
require 'json'
require 'pry'

post '/' do
  parsed_request = JSON.parse(request.body.read)
  this_is_the_first_question = parsed_request["session"]["new"]
    if this_is_the_first_question
    return {
      version: "1.0",
      sessionAttributes: {
        numberOfRequests: 1
      },
      response: {
        outputSpeech: {
          type: "PlainText",
          text: "This is the first question"
        }
      }
    }.to_json
  end

  return {
    version: "1.0",
    response: {
      outputSpeech: {
        type: "PlainText",
        text: "This is question number 2"
      }
    }
  }.to_json
end
