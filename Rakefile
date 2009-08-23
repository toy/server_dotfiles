require 'pathname'
require 'tempfile'

desc 'default - install'
task :default => :install

desc 'install dotfiles'
task :install do
  def red(s)
    puts("\e[1;31m#{s}\e[0m")
  end

  class Pathname
    def merge(other)
      Tempfile.open('merge') do |src|
        return `git-merge-file -p -q #{self} #{src.path} #{other}`
      end
    end

    def write(data)
      open('wb') do |f|
        return f.write(data)
      end
    end
  end

  home = Pathname('~').expand_path
  rakefile = Pathname(__FILE__)

  Dir.chdir(rakefile.dirname) do
    (Pathname.glob('**/*') - [rakefile.basename]).each do |file|
      if file.file?
        src = file.expand_path

        dst_name = if file.to_s == 'profile'
          profile_files = %w(bash_profile bash_login profile)
          profile_files.find{ |profile| (home + ".#{profile}").exist? } || profile_files.first
        else
          file
        end
        dst = home + ".#{dst_name}"

        if dst.exist?
          if dst.symlink?
            if dst.readlink != src
              red "#{dst} points to #{dst.readlink} instead of #{src}"
            end
          else
            data = src.merge(dst)
            dst.unlink
            dst.make_symlink(src)
            if src.read != data
              src.write(data)
              `#{ENV['EDITOR'] || 'vim'} #{src}`
            end
          end
        else
          puts "#{dst} => #{src}"
          dst.make_symlink(src)
        end
      end
    end
  end
end
