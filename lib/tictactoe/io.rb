class InputOutput

  def input
    gets.chomp
  end

  def outputs(message)
    puts message
  end

  def outputs_header(message)
    puts "      #{message}\n"
  end


  def prints(message)
  	print message
  end
end
