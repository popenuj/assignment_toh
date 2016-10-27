class TowerOfHanoi
	def initialize disks
		start(disks)
	end
	def start(disks)
		if disks.to_i <= 1
			puts "Please start your game off with at least two disks!"
			disks = gets.chomp
			start(disks)
		end
		@disks = disks.to_i
		@peg_height = disks.to_i
		@pegs = [[],[],[]]
		set_board
		winning_if
		instructions
	end
	#sets up first peg for beginning of game
	def set_board
		(1..@disks).each do |disk|
			@pegs[0].unshift disk
		end
	end
	#set winning condition
	def winning_if
		@win_condition = @pegs[0].dup
	end
	#instructions
	def instructions
		puts "Hello and welcome to Tower of Hanoi!"
		puts "Your objective in this game is to move all of the disks from post 1 to post 3."
		puts "You may only move one disk at a time and you may not place a larger disk on top of a smaller disk."
		puts "To make a move simply type in the number of the peg you would like to take a disk from, a comma, and then the number of the peg you would like to move the disk to. e.g. (1,3)."
		puts "If you would like to quit at any time simply type 'quit'!"
		puts "Give it a shot young grasshopper!"
		render
	end
	#render game
	def render
		(@peg_height-1).downto(0).each do |row|
			puts
			@pegs.each do |peg|
				if peg[row] == nil
					print "|" + (' ' * @disks) + "|"
				else
					disk_render = "o" * peg[row]
					print "|" + disk_render.center(@disks) + "|"
				end
			end
		end
		puts
		(1..3).each do |number|
			print number.to_s.center(@disks + 2)
		end
		win?
	end
	#checks to see if winning condition is met
	def win?
		if @win_condition == @pegs[2]
			puts "\nCongratulations! You have solved this Tower of Hanoi! Would you like to start over? Please enter 'y' for yes or 'n' for no!"
			response = gets.chomp.downcase
			play_again?(response)
		end
		puts "\nPlease make your next move!"
		move_input
	end
	#restarts or ends another game based on player input
	def play_again?(response)
		if response == "y"
			puts "How many disks would you like to play with this time?"
			disks = gets.chomp.to_i
			start(disks)
		elsif response == "n"
			puts "Thanks for playing!"
			exit
		else
			puts "Please enter either 'y' for yes or 'n' for no."
			response = gets.chomp.downcase
			play_again?(response)
		end
	end
	#gets player move
	def move_input
		move = gets.chomp
		if move.downcase == "quit" || move.downcase == "q"
			exit
		end
		move = move.split ','
		@take_from = move[0].to_i - 1
		@move_to = move[1].to_i - 1
		valid_move?
		illegal_move?
		move_disks
	end
	#checks move input validity
	def valid_move?
		valid_1 = (0..2).include? (@take_from)
		valid_2 = (0..2).include? (@move_to)
		if valid_1 == false || valid_2 == false
			puts "I'm sorry, please input your move in a 'x,y' format, ensuring that you are selecting numbers between 1 and 3!"
			move_input
		elsif @pegs[@take_from][0] == nil
			puts "I'm sorry, I'm not in the mood for a philosophical debate so let's just agree that you cannot move nothing and you can try again."
			move_input
		end
	end
	#checks move's legality
	def illegal_move?
		if @pegs[@move_to][-1] == nil
			puts "move_disks"
		elsif @pegs[@take_from][-1] > @pegs[@move_to][-1]
			puts "You cannot place a larger disk on top of a smaller disk, try again!"
			move_input
		end
	end
	#moves disks
	def move_disks
		disk = @pegs[@take_from].pop
		@pegs[@move_to].push disk
		render
	end
end

game = TowerOfHanoi.new 20
