module Bob

  class Git

     def self.build_commit(build)
      command = "git log --max-count=1 --format=\"%H%n%an%n%ae%n%ad%n%s\" #{build.project.branch_name}"
      info = Runner.run(build.build_dir, command).split(/\n/)
      ## update git information
      commit = Commit.new
      commit.author = info[1]
      commit.author_email = info[2]
      commit.guid = info[0]
      commit.message = info[4]
      commit.build = build
      commit.project = build.project
      build.commits << commit
      build.save
    end

    def self.checkout(build)
      "git clone --branch #{build.project.branch_name} --depth 1 #{build.project.scm_path} #{build.build_dir}"
    end

  end

end
