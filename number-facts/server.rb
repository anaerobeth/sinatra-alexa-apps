require 'sinatra'
require 'json'
require 'net/http'

# To test, enter this utterance in the Service Simulator:
# Number Facts about five
# then click 'Ask NumberFacts'
# Expected response is:
#
# "intent": {
#   "name": "NumberFact",
#   "slots": {
#     "Number": {
#       "name": "Number",
#       "value": "5"
#     }
#   }
# }

post '/' do
  parsed_request = JSON.parse(request.body.read)["request"]["intent"]["slots"]
  number = parsed_request["Number"]["value"]
  fact_type = parsed_request["FactType"]["value"].downcase

  valid_fact_type = ['math', 'trivia'].include? fact_type

  message = if valid_fact_type
    Net::HTTP.get("http://numbersapi.com/#{ number }/#{ fact_type }")
  else
    "I can only give you math or trivia facts"
  end

  to_json(message)
end

def to_json(message)
  {
    version: "1.0",
    response: {
      outputSpeech: {
        type: "PlainText",
        text: message
      }
    }
  }.to_json
end

