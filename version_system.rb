class Versioned
  def self.support
    ["1.0", "1.1", "1.2"]
  end
  
  def self.supported?(version)
    support.include?(version)
  end
  
  def self.hash_for(version)
    base_hash = {
      "a" => 111, "b" => 112, "c" => 113, "d" => 121, "e" =>  122, "f" => 123, "g" => 131, "h" =>  132,
      "i" => 133, "j" => 211, "k" => 212, "l" => 213, "m" =>  221, "n" => 222, "o" => 223, "p" =>  231,
      "q" => 232, "r" => 233, "s" => 311, "t" => 312, "u" =>  313, "v" => 321, "w" => 322, "x" =>  323,
      "y" => 331, "z" => 332, " " =>   0, "\t" =>  1, "." =>  444, "?" => 445, "!" => 446, "@" =>  454,
      "#" => 455, "%" => 456, "^" => 464, "&" => 465, "*" =>  466, "(" => 544, ")" => 545, "-" =>  546,
      "_" => 554, "=" => 555, "+" => 556, "[" => 564, "{" =>  565, "]" => 566, "}" => 644, "\\" => 645,
      "|" => 646, ";" => 654, ":" => 655, "'" => 656, "\"" => 664, "/" => 665, "," => 666
    }
    
    if version == "1.0"
      base_hash
    elsif version == "1.1"
      base_hash.merge "<" => 744, ">" => 745, "$" => 746
    elsif version == "1.2"
      base_hash.merge "<" => 744, ">" => 745, "$" => 746
      base_hash.merge "~" => 754, "`" => 755
    else
      {}
    end
  end
  
  def self.next_token_for(version)
    "9"
  end
  
  def self.cap_token_for(version)
    "C"
  end
  
  def self.digit_token_for(version)
    "D"
  end
end 