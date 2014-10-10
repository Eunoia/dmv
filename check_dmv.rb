require 'mechanize'
require './mechanize_better_fetch.rb'
require 'json'
require 'pry'
require 'fog'
require 'slim'
require './CaliforniaDMV.rb'
require './push_stuff_to_the_cloud.rb'

class CheckDMV

  extend PushStuffToTheCloud
  extend CaliforniaDMV

  def self.update_listing
    @mechanize = Mechanize.new
    data = offices.inject({}) do |hash, (office_id,office_name)|
      puts office_name
      times = get_tasks_at_office(office_id)
      hash[office_name] = Hash[tasks.zip(times)]
      hash
    end
    renderToS3(data)
  end

  def self.get_tasks_at_office(office_id)
    foo = tasks.map do |task|
      print "#{task}: \t"
      page = get_task_at_office(task,office_id)
      time = next_available_time(page)
      binding.pry if time.nil?
      break if time.nil?
      puts time
      time
    end
  end

  def self.get_task_at_office(task,office_id)
    options = {}
    options[task] = true
    options[:officeId] = office_id
    options.merge!(default_options)
    @mechanize.post(url,options)
  end

  def self.next_available_time(page)
    alerts = (page/"p.alert")
    alerts[1].nil? ? "This office is currently not available." : alerts[1].text
  end

  def self.renderToS3(data)
    template = Slim::Template.new("index.slim")
    html = template.render(data)
    json = data.to_json
    print html
    saveToS3(html,json)
  end

end
