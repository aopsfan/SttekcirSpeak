load 'version_system.rb'

class Encoder
  def initialize(version)
    @version = version
    @data = Versioned.hash_for(@version)
  end
  
  def encode(input)
    characters = input.split(//)
    output = []
    errors = []
    error_message = "The following characters are not supported by version #{@version}: "
    
    characters.each do |char|
      if is_capital_character?(char)
        output << Versioned.cap_token_for(@version) + @data[char.downcase].to_s + Versioned.next_token_for(@version)
      elsif is_digit?(char)
        output << Versioned.digit_token_for(@version) + char + Versioned.next_token_for(@version)
      elsif is_unknown?(char)
        errors << char unless errors.include?(char)
      else
        output << @data[char].to_s + Versioned.next_token_for(@version)
      end
    end
    
    combined_output = "#{@version}V#{output.join("")}"
    
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
      return !@data[input] && @data[input.downcase]
    end
    
    def is_unknown?(input)
      return !@data[input] && !is_capital_character?(input) && !is_digit?(input)
    end
end