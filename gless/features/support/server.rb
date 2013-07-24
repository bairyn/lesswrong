# Utilities for interacting with the daemon.

module LesswrongUtil
  module Server
    require 'fileutils'

    include Config

    # Base LW dir.
    def base_dir
      File.join File.dirname(__FILE__), '..', '..', '..'
    end

    # Return the r2 directory.  If a block is given, run the block in the given
    # directory, and then also return the directory.
    def run_dir &block
      dir = File.join base_dir, 'r2'
      FileUtils.chdir(dir) &block if block_given?
      dir
    end

    def script_dir
      File.join base_dir, 'scripts'
    end

    def ini_filepath
      File.join run_dir, ini_filename
    end

    # Pass "paster run" to the command line with the given file and command.
    # If +ini_override+ exists, it overrides +ini_filepath.
    def system_paster_cmd file_path, cmd = nil, ini_override = nil
      run_dir do
        if cmd
          system('paster', 'run', '-c', cmd, file_path, ini_override || ini_filepath)
        else
          system('paster', 'run', file_path, ini_override || ini_filepath)
        end
      end
    end

    # Wrapper over system_paster_cmd that treats the file_path relative to the
    # scripts directory.
    def system_paster_script script_file, cmd = nil, ini_override = nil
      system_paster_cmd File.join(script_dir, script_file), cmd, ini_override
    end

    def configure_discussion
      system_paster_script 'configure_discussion_subreddit.py', 'configure_discussion()'
    end
  end
end
