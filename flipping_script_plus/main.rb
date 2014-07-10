require_relative 'sublist'


def work_with_list
  puts "Substitute list: [R]ead, [E]dit, [D]elete, or [B]ack:"
  option = gets.chomp.downcase
  
  case option
    when 'r'
      read_list
    when 'e'
      edit_list
    when 'b'
      File::open('sublist.rb', 'w') { |f| f << "$sub_list = #{$sub_list}"}
      main
    when 'd'
      delete_list_item
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

  $sub_list.merge!(Hash[edit_pair[0], edit_pair[1]])
  puts "done"
  work_with_list
end

def delete_list_item
  puts "What pair would you like to delete? (enter first word only)"
  delete_this = gets.chomp
  puts delete_this + " - #{ $sub_list[delete_this] } pair deleted"
  $sub_list.delete(delete_this)
  work_with_list
end

def flip_a_script
  puts "Which file contains the script?"
  script_name = gets.strip.downcase
  open_script = File::read(script_name)
  
  $sub_list.each do |word, replacement|
    open_script.gsub!(word, replacement)
  end
  
  puts "done"
  puts open_script
  File::open(script_name, 'w') do |f|
    f << open_script
  end
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
    