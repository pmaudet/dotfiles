#!/usr/bin/env ruby

class Task
  attr_accessor :name, :description
  attr_reader   :body

  def initialize(name, description, body=[])
    @name        = name
    @description = description
    @body        = body
  end

  def to_s
    "#{name}: #{description} -- #{body.inspect}"
  end

  def clean_description
    description.to_s.strip
  end

  def clean_body
    body.map { |line| "  " + line.strip }.join("\n").rstrip
  end

  def to_bash_function
    lines = []

    lines << "# #{clean_description}" unless clean_description.empty?
    lines << "bake_task_#{name}() {"
    lines << clean_body
    lines << "}"
    lines << ""

    lines.join("\n")
  end
end

#-------------------------------------------------

class TaskAggregator
  def initialize
    @tasks = []
    @description = nil
  end

  def handle(line)
    # new task
    if line =~ /^task "([^"]+)"/
      tasks << Task.new($1, @description)
      return
    end

    # keep last comment line as description
    if line =~ /^#(.*)$/
      @description = $1
      return
    else
      @description = nil
    end

    # body
    unless @tasks.empty?
      @tasks.last.body << line
    end
  end

  def tasks
    @tasks # -- for now
  end
end

#-------------------------------------------------

aggregator = TaskAggregator.new

ARGF.each_line do |line|
  aggregator.handle(line)
end

puts <<END
# autogenerated
invoke() {
  local task="$1"

  echo "-> $task"
  "bake_task_$task"
}
END

puts "# autogenerated"
puts "bake_tasks() {"
  aggregator.tasks.each do |task|
    if task.clean_description.empty?
      puts "  echo 'bake #{task.name}'"
    else
      puts "  echo 'bake #{task.name.ljust(20)} # #{task.clean_description}'"
    end
  end
puts "}"

aggregator.tasks.each do |task|
  puts task.to_bash_function
end

