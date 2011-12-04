load 'version_system.rb'

class Decoder
  def decode(input)
    @manager = VersionManager.new
    
    split = split_for(input)
    @version = split[:version]
    @reverse_data = @version.hash.invert
    
    numbers = split[:input]
    
    new_numbers = []
    
    i = 0

    numbers.each do |number|
      if number == @version.next_token && new_numbers[i] != @version.digit_token
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
        
        letters << @reverse_data[new_number.to_i].capitalize if char == @version.cap_token
        letters << new_number if char == @version.digit_token
      else
        letters << @reverse_data[number.to_i]
      end
    end

    {
      :output => letters.join(""),
      :version => @version.id,
      :errors => "No errors!"
    }
  # rescue
  #   if !@version
  #     {
  #       :output => "No output",
  #       :version => "",
  #       :errors => "No version"
  #     }
  #   else
  #     {
  #       :output => "No output",
  #       :version => @version.id,
  #       :errors => "Invalid code or version (your current version is #{@version.id}, latest version is #{VersionSupport.latest_version})."
  #     }
  #   end
  end
  
  private
  
    def split_for(input)
      array = input.split('V')
      version = array.first
      new_numbers = array.last.split(//)
      
      {
        :version => @manager.version_with(version),
        :input => new_numbers
      }
    end
  
    def split?(number)
      character = number.split(//).first
      if character == @version.cap_token || character == @version.digit_token
        true
      else
        false
      end
    end    
end