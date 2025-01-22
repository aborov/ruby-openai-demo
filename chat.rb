require "openai"
require "dotenv/load"

client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))

# Prepare an Array of previous messages
conversation = [{ role: "system", content: "You are a helpful assistant." }]

puts "Hello! How can I help you today?"
puts "-" * 50

loop do
  user_input = gets.chomp.strip
  break if user_input.downcase == "bye"
  conversation << { role: "user", content: user_input }

  # Call the API to get the next message from GPT
  api_response = client.chat(
    parameters: {
      model: "gpt-3.5-turbo",
      messages: conversation
    }
  )

  reply = api_response.dig("choices", 0, "message", "content")

  conversation << { role: "assistant", content: reply }

  puts reply
  puts "-" * 50
end

puts "Goodbye!"
