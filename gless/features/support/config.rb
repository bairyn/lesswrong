# Lesswrong Test configuration for cucumber.

module LesswrongUtil
  module Config
    def ini_filename
      'test.ini'
    end

    def about_post_body
      <<-EOM
        Ah, computer dating. It's like pimping, but you rarely have to use the phrase "upside your head." I'm a thing. Robot 1-X, save my friends!  And Zoidberg! Calculon is gonna kill us and it's all everybody else's fault! For one beautiful night I knew what it was like to be a grandmother. Subjugated, yet honored. And yet you haven't said what I told you to say! How can any of us trust you?
        Have you ever tried just turning off the TV, sitting down with your children, and hitting them? Leela, are you alright? You got wanged on the head. Well, thanks to the Internet, I'm now bored with sex. Is there a place on the web that panders to my lust for violence? Now, now. Perfectly symmetrical violence never solved anything. Kif might!
        Wow! A superpowers drug you can just rub onto your skin? You'd think it would be something you'd have to freebase. Maybe I love you so much I love you no matter who you are pretending to be. Oh, how I wish I could believe or understand that! There's only one reasonable course of action now: kill Flexo! Guards! Bring me the forms I need to fill out to have her taken away!
        Noooooo! Dr. Zoidberg, that doesn't make sense. But, okay! No! Don't jump!
        Why am I sticky and naked? Did I miss something fun? Say what? And so we say goodbye to our beloved pet, Nibbler, who's gone to a place where I, too, hope one day to go. The toilet. Why yes! Thanks for noticing. Morbo will now introduce tonight's candidates... PUNY HUMAN NUMBER ONE, PUNY HUMAN NUMBER TWO, and Morbo's good friend, Richard Nixon. No. We're on the top.
      EOM
    end
  end
end
