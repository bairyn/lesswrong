# Lesswrong Test configuration for cucumber.

module LesswrongUtil
  module Config
    def ini_filename
      'test.ini'
    end

    def about_post_body
      <<-EOM
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus ultrices risus neque, at ultricies neque hendrerit non. Sed sit amet iaculis massa, cursus faucibus felis. Cras viverra sit amet massa egestas pretium. Cras porttitor malesuada nibh, ac posuere mauris fermentum vel. Nulla nisi quam, sagittis nec imperdiet at, molestie eget urna. Quisque varius dolor odio, a venenatis turpis dapibus et. Aliquam accumsan, tortor quis adipiscing vulputate, lacus velit viverra erat, non fermentum est neque a enim. Donec sagittis velit nec pharetra congue. Aenean nunc mauris, porta eu semper vel, congue id orci.
        Mauris quis convallis magna, ut hendrerit nulla. Praesent eget ornare velit. Suspendisse scelerisque lacus sed laoreet lacinia. Donec molestie neque rutrum placerat venenatis. Donec ut mollis tellus, sed egestas elit. Curabitur semper, magna sed imperdiet malesuada, dolor lorem porta elit, id tempus nisl leo sed nunc. Curabitur tortor elit, tincidunt sodales ullamcorper at, mollis pharetra dolor. Cras vitae bibendum massa, quis tempor velit.
      EOM
    end
  end
end
