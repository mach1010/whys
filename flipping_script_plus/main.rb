require_relative 'sublist'


def work_with_list
  puts "Substitute list: [R]ead or [E]dit:"
  option = gets.chomp.downcase
  
  case option
    when 'r'
      read_list
    when 'e'
      edit_list
    else
      puts "That's not an option"
      work_with_list
  end
  
end

def read_list
  $sub_list.each { |k, v| puts "replace " + k.upcase + " with " + v.upcase + "\n" }
  work_with_list
end

def edit_list
  $sub_list.each { |k, v| puts "replace " + k.upcase + " with " + v.upcase + "\n" }
  puts "enter new pair separated by a comma (if the pair exists it is replaced with your update)"
  edit_pair = gets.chomp.split(", ")
  file = File::open('sublist.rb', 'w') do |f|
    f << "$sub_list = #{$sub_list.merge!(Hash[edit_pair[0], edit_pair[1]])}"   
  end
  puts "done"
  work_with_list
end

def flip_a_script
  main
end 

def main
  puts "[W]ork with substitute list or [F]lip a script?"
  option = gets.chomp.downcase
  
  case option
  when 'w'
    work_with_list
  when 'f'
    flip_a_script
  else
    puts "That's not an option"
    main
  end
end

main
    