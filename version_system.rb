load 'version.rb'

class VersionManager
  attr_accessor :all_versions, :latest_version
  
  def initialize
    one_zero_hash = {
      "a" => 111, "b" => 112, "c" => 113, "d" => 121, "e" =>  122, "f" => 123, "g" => 131, "h" =>  132,
      "i" => 133, "j" => 211, "k" => 212, "l" => 213, "m" =>  221, "n" => 222, "o" => 223, "p" =>  231,
      "q" => 232, "r" => 233, "s" => 311, "t" => 312, "u" =>  313, "v" => 321, "w" => 322, "x" =>  323,
      "y" => 331, "z" => 332, " " =>   0, "\t" =>  1, "." =>  444, "?" => 445, "!" => 446, "@" =>  454,
      "#" => 455, "%" => 456, "^" => 464, "&" => 465, "*" =>  466, "(" => 544, ")" => 545, "-" =>  546,
      "_" => 554, "=" => 555, "+" => 556, "[" => 564, "{" =>  565, "]" => 566, "}" => 644, "\\" => 645,
      "|" => 646, ";" => 654, ":" => 655, "'" => 656, "\"" => 664, "/" => 665, "," => 666
    }
    one_one_hash = one_zero_hash.merge("<" => 744, ">" => 745, "$" => 746)
    one_two_hash = one_one_hash.merge("~" => 754, "`" => 755)
    
    one_zero = Version.new({
      :id => "1.0",
      :hash => one_zero_hash,
      :next_token => "9",
      :cap_token => "C",
      :digit_token => "D"
    })
    one_one = Version.new({
      :id => "1.1",
      :hash => one_one_hash,
      :next_token => "9",
      :cap_token => "C",
      :digit_token => "D"
    })
    one_two = Version.new({
      :id => "1.2",
      :hash => one_two_hash,
      :next_token => "9",
      :cap_token => "C",
      :digit_token => "D"
    })
    
    @all_versions = [one_zero, one_one, one_two]
    @latest_version = @all_versions.last
  end
  
  def version_with(id)
    v = @all_versions.detect do |version|
      version.id == id
    end
    
    return v
  end
end