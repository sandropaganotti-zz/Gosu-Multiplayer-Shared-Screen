class Player 
 
  class << self
    def set_window!(window)
      @@window = window
    end
    def dispatch(msg)
      puts "msg: #{self.players.inspect}" unless msg.nil?
      (self.players[(tokens=msg.split('|'))[0].to_i] ||= new(@@window)).capture_command(tokens[1..-1]) unless msg.nil?
    end
    def players
      @@players ||= []
    end
    def each
      self.players.each{|p|yield(p)} if block_given? 
    end
  end
  
  def initialize(window)
    @window = window
    @image = Gosu::Image.new(@window, "media/ship.png", true)
    @y = @window.height - @image.height * 2
    @x = (@window.width  - @image.width)/ 2
  end
  
  def capture_command(tokens)
    case @last_command = tokens.to_s.to_sym
      when :left  then @x = @x - 1
      when :right then @x = @x + 1  
      when :close then Player.players.delete(self)
    end
  end
  
  def draw
    @image.draw(@x,@y,1)
  end
  
end