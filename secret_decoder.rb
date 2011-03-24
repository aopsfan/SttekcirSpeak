load 'version_system.rb'

class Decoder
  def initialize
    @version = Versioned.support.last
    @reverse_data = {}
  end
  
  def decode(input)
    @version = split_for(input)[:version]
    @reverse_data = Versioned.hash_for(@version).invert
    
    numbers = split_for(input)[:input]
    
    new_numbers = []
    
    i = 0

    numbers.each do |number|
      if number == Versioned.next_token_for(@version) && new_numbers[i] != Versioned.digit_token_for(@version)
        i += 1
      elsif !new_numbers[i]
        new_numbers << number
      else
        new_numbers[i].concat(number)
      end
    end
    
    letters = []

    new_numbers.each do |number|
      if split?(number)
        array = number.split(//)
        char = array.delete_at(0)
        new_number = array.join("")
        
        letters << @reverse_data[new_number.to_i].capitalize if char == Versioned.cap_token_for(@version)
        letters << new_number if char == Versioned.digit_token_for(@version)
      else
        letters << @reverse_data[number.to_i]
      end
    end

    {
      :output => letters.join(""),
      :version => @version,
      :errors => "No errors!"
    }
  rescue
    errors = []
    
    {
      :output => "No output",
      :version => @version,
      :errors => "Invalid code or version (your current version is #{@version}, latest version is #{Versioned.support.last})."
    }
  end
  
  private
  
    def split_for(input)
      array = input.split('V')
      version = array.first
      new_numbers = array.last.split(//)
      
      {
        :version => version,
        :input => new_numbers
      }
    end
  
    def split?(number)
      character = number.split(//).first
      if character == Versioned.cap_token_for(@version) || character == Versioned.digit_token_for(@version)
        true
      else
        false
      end
    end    
end