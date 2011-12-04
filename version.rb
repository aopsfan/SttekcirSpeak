class Version
  attr_accessor :id, :hash, :next_token, :cap_token, :digit_token
  
  def initialize(hash = {})
    @id = hash[:id]
    @hash = hash[:hash]
    @next_token = hash[:next_token]
    @cap_token = hash[:cap_token]
    @digit_token = hash[:digit_token]
  end
  
  def self.support
    ["1.0", "1.1", "1.2"]
  end
end