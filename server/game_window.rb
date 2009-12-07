
class GameWindow < Gosu::Window
  def initialize(h=640, w=480)
    super(h,w,false)
    @server  = TCPServer.new("127.0.0.1",8888)
    @connection_pool = []
    Player.set_window!(self)
  end
  
  def draw
    (@connection_pool << (@server.accept_nonblock rescue nil)).compact!; @connection_pool.delete_if do |ts|
        delete = false
        Player.dispatch((ts.readline.chomp rescue (delete = true; nil))) 
        ts.write("next\n") rescue (delete = true)
        delete
    end    
    Player.each{|p| p.draw if p.respond_to?(:draw)}
  end
  
end