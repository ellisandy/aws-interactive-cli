require 'aws-sdk'
require 'questions'

class BaseMethods
  
  # Returns array of regions
  def self.describe_regions
    regions = AWS::Core::RegionCollection.new
    @array = []
    regions.each { |region| @array << region.name }
    # regions.each do | region |
    #   @array << region.name
    # end
  end
  
  # Returns array of instances in specific region
  def self.describe_instance_by_region(region)
    # TODO Refactor
    @instances = []
    client = AWS::EC2::Client.new(:region => region)
    instances = client.describe_instances
    instances[:reservation_set].each do | instance |
      @tags = []
      instance[:instances_set].first[:tag_set].each do |tag|
        @tags << {tag[:key] => tag[:value]}
        if tag[:key] == "Name"
          @name = tag[:value]
        end
      end

      hash = {
        :instance_id => instance[:instances_set].first[:instance_id],
        :ip_address => instance[:instances_set].first[:ip_address],
        :instance_state => instance[:instances_set].first[:instance_state][:name],
        :launch_time => instance[:instances_set].first[:launch_time],
        :name => @name,
        :keypair => instance[:instances_set].first[:key_name]
      }
      @tags.each do |tag| 
        hash.merge!(tag)
      end

      @instances << hash
    end
    return @instances
  end
  
  def self.instance_action(instance_id, action, region)
    ec2 = AWS::EC2.new(:region => region)
    i = ec2.instances[instance_id]
    if action == "start"
      i.start
    elsif action == "stop"
      i.stop
    elsif action == "terminate"
      i.terminate
    else
    end
  end
  
  def self.start_over(region)
    
    question = Questions.new
    
    # Start Process
    if region == "none"
      # Select a region
      @region = question.region
    else
      @region = region
    end

    # Select an Instance
    @selected_instance = question.select_instance(@region)

    # Select the action
    @instance = question.instance_action(@selected_instance)
  end
end