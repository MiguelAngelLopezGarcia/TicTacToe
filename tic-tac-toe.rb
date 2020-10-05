#Defining classes for the board and the players

class SquaresToPlay
    
    @@owns = []
    attr_accessor :name
    def initialize (name)
        @name = name
        @@owns << self
    end

    def name=(letter)
        @name = letter
    end

    def name
        @name
    end

    def self.owns
        @@owns
    end
    
end

one = SquaresToPlay.new("1")
two = SquaresToPlay.new("2")
three = SquaresToPlay.new("3")
four = SquaresToPlay.new("4")
five = SquaresToPlay.new("5")
six = SquaresToPlay.new("6")
seven = SquaresToPlay.new("7")
eight = SquaresToPlay.new("8")
nine = SquaresToPlay.new("9")

class Xs

    @@owns = []
    attr_accessor :name
    def initialize (name)
        @@owns.push(name)
    end

    def self.owns
        @@owns
    end

    def self.reset
        @@owns = []
    end

end

class Os

    @@owns = []
    attr_accessor :name
    def initialize (name)
        @@owns.push(name)
    end

    def self.owns
        @@owns
    end

    def self.reset
        @@owns = []
    end
    
end

#The game: Turns between X and O, before each turn it checks if there are squares to play and if there is a winner already

def play_game
    squares_availables = 9

    board

    while winner? == false && still_space_to_play?(squares_availables)
        play_game_as_x
        squares_availables -= 1
        if still_space_to_play?(squares_availables) && winner? == false
            play_game_as_o
            squares_availables -= 1
        else 
            break
        end
    end

    announce_winner

    squares_availables = 9

    next_game

end


def board
    puts "     |     |     "
    puts "  #{SquaresToPlay.owns[0].name}  |  #{SquaresToPlay.owns[1].name}  |  #{SquaresToPlay.owns[2].name}  "  
    puts "_____|_____|_____"
    puts "     |     |     "
    puts "  #{SquaresToPlay.owns[3].name}  |  #{SquaresToPlay.owns[4].name}  |  #{SquaresToPlay.owns[5].name}  "  
    puts "_____|_____|_____"
    puts "     |     |     "
    puts "  #{SquaresToPlay.owns[6].name}  |  #{SquaresToPlay.owns[7].name}  |  #{SquaresToPlay.owns[8].name}  "  
    puts "     |     |     "
end

# How turns works: get the number from user, change the name from the square class and add a new instance to X or O

def play_game_as_x

    puts "Es el turno de las X. \nEscribe el número de la casilla que quieras y pulsa enter."
    square_to_change = gets.chomp

    i = 0
    storage = 0
    9.times do
        if SquaresToPlay.owns[i].name.include?(square_to_change) 
            storage = i
        end
        i += 1
    end

    if SquaresToPlay.owns[storage].name.include?(square_to_change) == false
        puts "Esta casilla ya ha sido jugada o no existe, por favor introduzca otro número."
        play_game_as_x
    else
        SquaresToPlay.owns[storage].name = "X"
        Xs.new(square_to_change)
        board
    end

end

def play_game_as_o

    puts "Es el turno de las O. \nEscribe el número de la casilla que quieras y pulsa enter."
    square_to_change = gets.chomp

    i = 0
    storage = 0
    9.times do
        if SquaresToPlay.owns[i].name.include?(square_to_change) 
            storage = i
        end
        i += 1
    end

    if SquaresToPlay.owns[storage].name.include?(square_to_change) == false
        puts "Esta casilla ya ha sido jugada o no existe, por favor introduzca otro número."
        play_game_as_o
    else
        SquaresToPlay.owns[storage].name = "O"
        Os.new(square_to_change)
        board
    end

end

# Winner is defined by Arrays from the cases below and the Arrays of X and O classes

def winner?
    case_1 = ["1", "2", "3"]
    case_2 = ["4", "5", "6"]
    case_3 = ["7", "8", "9"]
    case_4 = ["1", "4", "7"]
    case_5 = ["2", "5", "8"]
    case_6 = ["3", "6", "9"]
    case_7 = ["1", "5", "9"]
    case_8 = ["3", "5", "7"]

    if (case_1 - Xs.owns).empty? || (case_2 - Xs.owns).empty? || (case_3 - Xs.owns).empty? || (case_4 - Xs.owns).empty? || (case_5 - Xs.owns).empty? || (case_6 - Xs.owns).empty? || (case_7 - Xs.owns).empty? || (case_8 - Xs.owns).empty?
        return true
    elsif (case_1 - Os.owns).empty? || (case_2 - Os.owns).empty? || (case_3 - Os.owns).empty? || (case_4 - Os.owns).empty? || (case_5 - Os.owns).empty? || (case_6 - Os.owns).empty? || (case_7 - Os.owns).empty? || (case_8 - Os.owns).empty?
        return true
    else   
        return false
    end
    
end

def still_space_to_play? (squares_availables)

    squares_availables > 0 ? true : false

end

def announce_winner
    case_1 = ["1", "2", "3"]
    case_2 = ["4", "5", "6"]
    case_3 = ["7", "8", "9"]
    case_4 = ["1", "4", "7"]
    case_5 = ["2", "5", "8"]
    case_6 = ["3", "6", "9"]
    case_7 = ["1", "5", "9"]
    case_8 = ["3", "5", "7"]

    if (case_1 - Xs.owns).empty? || (case_2 - Xs.owns).empty? || (case_3 - Xs.owns).empty? || (case_4 - Xs.owns).empty? || (case_5 - Xs.owns).empty? || (case_6 - Xs.owns).empty? || (case_7 - Xs.owns).empty? || (case_8 - Xs.owns).empty?
        puts "¡¡¡GANAN LAS X!!!"
    elsif (case_1 - Os.owns).empty? || (case_2 - Os.owns).empty? || (case_3 - Os.owns).empty? || (case_4 - Os.owns).empty? || (case_5 - Os.owns).empty? || (case_6 - Os.owns).empty? || (case_7 - Os.owns).empty? || (case_8 - Os.owns).empty?
        puts "¡¡¡GANAN LAS O!!!"
    else   
        puts "¡Es un empate!"
    end
end

# Reset the Array from the class X and O and the names in the square class

def next_game

    puts "¿Quieres jugar de nuevo? \nEscribe S para jugar de nuevo o N para dejar de jugar."
    answer = gets.chomp.downcase

    Xs.reset
    Os.reset
    i = 0
    j = 1
    9.times do
        SquaresToPlay.owns[i].name = j.to_s
        i += 1
        j += 1
    end
        

    if answer == "s"  
        play_game
    elsif answer != "s" && answer != "n" 
        puts "Por favor, escribe S para continuar jugando o N para dejar de jugar."
        next_game
    elsif answer == "n"
        return
    end

end

play_game