load 'version_system.rb'

class Encoder
  def initialize(version)
    @version = version
  end
  
  def encode(input)
    characters = input.split(//)
    output = []
    errors = []
    error_message = "The following characters are not supported by version #{@version.id}: "
    
    characters.each do |char|
      if is_capital_character?(char)
        output << @version.cap_token + @version.hash[char.downcase].to_s + @version.next_token
      elsif is_digit?(char)
        output << @version.digit_token + char + @version.next_token
      elsif is_unknown?(char)
        errors << char unless errors.include?(char)
      else
        output << @version.hash[char].to_s + @version.next_token
      end
    end
    
    combined_output = "#{@version.id}V#{output.join("")}"
    
    if errors.empty?
      errors = "No errors!"
      error_message = ""
    end
    
    {
      :output => combined_output,
      :error_message => error_message,
      :errors => errors
    }
  end
  
  private
  
    def is_digit?(input)
      return ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"].include?(input)
    end
    
    def is_capital_character?(input)
      return !@version.hash[input] && @version.hash[input.downcase]
    end
    
    def is_unknown?(input)
      return !@version.hash[input] && !is_capital_character?(input) && !is_digit?(input)
    end
end