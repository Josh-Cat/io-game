
require "socket"
joshua_socet=TCPServer.new 5555
loop {
  puts "serching for client"
  first_conetion=joshua_socet.accept
  begin
    what_client_sent_me = first_conetion.recv 2000
    puts "receved something"
    first_line = what_client_sent_me.lines[0]
    puts first_line
    puts first_line.split.inspect
    slash_thing = first_line.split[1]
    puts slash_thing.inspect
    #send_stuf = "<html><head><title>this title</title><head><body>this content #{slash_thing}<body><html>"
    send_stuf = File.read("#{slash_thing[1..-1]}")
    first_conetion.write "HTTP/1.0 200 OK\r\n"
    puts "going to send something"
    first_conetion.write "Content-Length: #{send_stuf.length}\r\n"
    puts "content leanth verifyed"
    first_conetion.write "\r\n"
    puts "pased blank line now to the code!"
    first_conetion.write send_stuf
    puts "sent the code"
  rescue => exception_ha
    puts "you make sever UNHAPPY" + exception_ha.to_s
  ensure
    first_conetion.close
    puts "now closed"  
  end
}



# write "HTTP/1.0 200 OK\r\n"
# write "\r\n" # write a blank line, after this comes the content:
# write "Hi from joshy!"
# write "<html><body><em>this is html!</em></body></html>"