def return_to_menu
  prompt = TTY::Prompt.new
  return_to_menu = prompt.select("Return to menu?",["Yes", "No"])
  if return_to_menu == "Yes"
    menu_method
  else
    puts "Goodbye!"
  end
end
