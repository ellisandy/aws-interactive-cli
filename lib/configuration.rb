require 'rubygems'
require 'highline/import'
require 'aws-sdk'

class StartingConfiguration

  def self.config

    # Setting the Config file Location
    config_file = "#{Dir.home}/.aws-config.yml"


    unless File.file?(config_file)
      begin
        entry = Hash.new

        say("Configuration Details:")

        entry[:access_key] = ask("Access Key:  ")
        entry[:secret_key] = ask("Secret Key:  ")
        entry[:path_to_keypairs] = ask("Path to keypairs(/path/to/keypairs/):  ")

      end

      File.open("#{config_file}", "w") { |file| YAML.dump(entry, file) }

    end

    AWS.config(YAML.load(File.read(config_file)))
    hash = YAML.load(File.read(config_file))

  end
  
  def self.path_to_keypair
    
    hash = YAML.load(File.read("#{Dir.home}/.aws-config.yml"))
    @path_to_keypairs = hash[:path_to_keypairs]
    
  end
end



