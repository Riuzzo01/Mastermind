class Game
  attr_accessor :code
  def initialize
    self.code = Array.new()
    puts  "Hello! Welcome to Mastermind!!"
    puts "Choose 1 to be a solver or 2 to be a builder!"
    role = gets.chomp
    while role != "1" && role != "2"
      puts "Error!! Choose 1 to be a solver or 2 to be a builder! "
    end

    if role == "1"
      playSolver
    else
      playBuilder
    end
  end

  def playSolver
    4.times {code.push rand(0..5).to_s}
    
    puts "A secret code has been generated!"
    puts "Now you have 12 tries to find it..."

    codeBroken = false
    turn = 1
    while turn != 13 && !codeBroken
      puts "Insert your try..."
      try = gets.chomp.split("")

      if try == self.code
        puts "Game finished; you WON!! You're an excellent code breaker!!"
        codeBroken = true
      else
        response = checkInput(try)
        puts "You have found #{response[0]} correct numbers in the correct position, #{response[1]} correct numbers in the wrong position and #{response[2]} wrong numbers"
        puts "Now you have #{12 - turn} tries"
      end
      turn += 1
    end

    puts "Game finished; you LOSE!! Bad luck??"
  end

  def checkInput(try)
    rightPosition = 0
    rightNumber = 0
    error = 0
    codeTemplate = self.code.join.split("")

    for i in 0..3
      if try[i] == codeTemplate[i]
        rightPosition += 1
        codeTemplate.delete_at(i)
      elsif codeTemplate.include?(try[i])
        rightNumber += 1
        codeTemplate.delete_at(codeTemplate.index(try[i]))
      else
        error += 1
      end
    end
    return [rightPosition, rightNumber, error]
  end

  def playBuilder
    puts "Insert the code.."
    self.code = gets.chomp.split("")
    puts "Now CPU has 12 tries to find it... Good luck!!"

    codeBroken = false
    turn = 1
    while turn != 13 && !codeBroken
      cpuTry = Array.new
      4.times {cpuTry.push rand(0..5).to_s}
      puts cpuTry.to_s
      
      if cpuTry == self.code
        puts "CPU WON!!"
        codeBroken = true
      else
        response = checkInput(cpuTry)
        puts "CPU have found #{response[0]} correct numbers in the correct position, #{response[1]} correct numbers in the wrong position and #{response[2]} wrong numbers"
        puts "Now CPU have #{12 - turn} tries"
      end
      turn += 1
    end

    puts "Game finished; you WON!!"
  end
end

game = Game.new
