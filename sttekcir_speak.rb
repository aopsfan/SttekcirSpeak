load 'secret_decoder.rb'
load 'secret_coder.rb'
require 'highline/import'

class SttekcirSpeak
  def self.welcome_with(password)
    return ask("Welcome to SttekcirSpeak.  Enter password: ") {|q| q.echo = "*"} == password
  end
  
  def self.ask_for_input
    tips_array = [
      "You cannot use `, ~, < or > in your messages",
      "A version is secretly hidden within each encoded message, so you don't have to enter your own enter one before decoding!",
      "This is certainly NOT a helpful tip :)"
    ]
    
    helpful_tip = tips_array[rand(tips_array.count)]
    
    puts("type 'decode' to decode a message written in SttekcirSpeak")
    puts("type 'encode' to encode a message written in English")
    puts("type 'quit' to exit")
    puts("Helpful Tip: #{helpful_tip}")   
    return ask(">> ")
  end
  
  def self.decode
    puts("You have chosen to decode")
    puts("You may now paste an encoded message:")
    decoder = Decoder.new
    puts("\n")
    input = ask("  input: ")
    hash = decoder.decode(input)
    puts(" output: #{hash[:output]}")
    puts("version: #{hash[:version]}")
    puts(" errors: #{hash[:errors]}")
    puts("\n")
    puts("\n")
  end
  
  def self.encode
    puts("You have chosen to encode")
    version = ask("Which version do you prefer to encode in (latest version is #{Versioned.support.last}): ")
    encoder = Encoder.new(version)
    puts("You may now type a message to encode:")
    puts("\n")
    input = ask(" input: ")
    hash = encoder.encode(input)
    puts("output: #{hash[:output]}")
    puts("errors: #{hash[:error_message]}#{hash[:errors]}")
    puts("\n")
    puts("\n")
  end
end

if SttekcirSpeak.welcome_with("")
  while true
    message = SttekcirSpeak.ask_for_input
    if message == 'decode'
      SttekcirSpeak.decode
    elsif message == 'encode'
      SttekcirSpeak.encode
    elsif message == 'quit'
      break
    end
  end
else
  puts("Incorrect password; terminating SttekcirSpeak.")
end
