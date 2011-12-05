load 'secret_decoder.rb'
load 'secret_coder.rb'
require 'highline/import'

class SttekcirSpeak 
  def self.welcome_with(password)
    if ask("Welcome to SttekcirSpeak.  Enter password: ") {|q| q.echo = ""} == password
      return ask("Enter second password: ") {|q| q.echo = true} == "~/Documents/My\\ Docs/Journal/B/B/Sttekcir\\ Speak/"
    else
      return false
    end
  end
  
  def self.ask_for_input
    tips_array = [
      "A version is secretly hidden within each encoded message, so you don't have to enter your own enter one before decoding!",
      "This is certainly NOT a helpful tip :)",
      "Try encoding an encoded message!"
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
  
  def self.encode(manager)
    puts("You have chosen to encode")
    version = ask("Which version do you prefer to encode in (latest version is #{manager.latest_version.id}): ")
    encoder = Encoder.new(manager.version_with(version))
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

if SttekcirSpeak.welcome_with("thegreatday")
  manager = VersionManager.new
  
  while true
    message = SttekcirSpeak.ask_for_input
    if message == 'decode'
      SttekcirSpeak.decode
    elsif message == 'encode'
      SttekcirSpeak.encode(manager)
    elsif message == 'quit'
      break
    end
  end
else
  puts("Incorrect password; terminating SttekcirSpeak.")
end
