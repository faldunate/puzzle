class MatrixGenerator


    def initialize(size)
        @size = size
        @matrix = generate_matrix
        @vertical_matrix = []
        @diagonal_left_matrix = []
        @diagonal_right_matrix = []
    end

    def generate_matrix
        arr = []
        @size.times do
            arr_length = []
            @size.times do
                arr_length.push(0)
            end
            arr.push(arr_length)
        end

        return arr
    end

    def populate
        @matrix.each do |items|
            items.map! {|item| ('a'..'z').to_a[rand(26)]}
        end
        puts "====== puzzle ========"
        puts @matrix.map { |a| a.map { |i| i.to_s.rjust(@size) }.join }
        generate_vertical_array
        generate_left_diagonal_array
        generate_right_diagonal_array
    end

    def generate_vertical_array
        @size.times do |index|
            arr_length = []
            @matrix.each do |item|
                arr_length.push(item[index])
            end
            @vertical_matrix.push(arr_length)
        end
    end

    def generate_left_diagonal_array
        index = 0
        @size.times do |_index|
            @diagonal_left_matrix.push(@matrix[_index][index])
            index = index + 1
        end
    end

    def generate_right_diagonal_array
        index = @size - 1
        @size.times do |_index|
            @diagonal_right_matrix.push(@matrix[_index][index])
            index = index - 1
        end
    end

    def find_words
        File.open("dict.txt", "r") do |f|
            f.each_line do |line|
                execute_finder(line.split(' ').to_a[0])
            end
        end
    end

    def execute_finder(word)
        find_horizontal_left_right(word)
        find_horizontal_right_left(word)
        find_vertical_top_bottom(word)
        find_vertical_bottom_top(word)
        find_diagonal_left_right(word)
        find_diagonal_right_left(word)
    end

    def find_horizontal_left_right(word)
        @matrix.each do |letters|
            if letters.join().include?(word.downcase)
                puts "the world #{word.downcase} exists - horizontal from left to right"
            end
        end
    end

    def find_horizontal_right_left(word)
        @matrix.each do |letters|
            if letters.reverse.join().include?(word.downcase)
                puts "the world #{word.downcase} exists - horizontal from right to left"
            end
        end
    end

    def find_vertical_top_bottom(word)
        @vertical_matrix.each do |letters|
            if letters.join().include?(word.downcase)
                puts "the world #{word.downcase} exists - vertical from top to bottom"
            end
        end
    end

    def find_vertical_bottom_top(word)
        @vertical_matrix.each do |letters|
            if letters.reverse.join().include?(word.downcase)
                puts "the world #{word.downcase} exists - vertical from bottom to top"
            end
        end
    end

    def find_diagonal_left_right(word)
        if @diagonal_left_matrix.join().include?(word.downcase)
            puts "the world #{word.downcase} exists - diagonal from left to right"
        end
    end

    def find_diagonal_right_left(word)
        if @diagonal_right_matrix.join().include?(word.downcase)
            puts "the world #{word.downcase} exists - diagonal from right to left"
        end
    end
end


da = MatrixGenerator.new(10)
da.populate
da.find_words