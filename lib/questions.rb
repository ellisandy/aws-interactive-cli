require 'rubygems'
require 'highline/import'
require 'aws-sdk'
require 'terminal-table'
require 'configuration'
require 'base_methods'


class Questions
  def region
    
    #Select a region
    choose do |menu|

      menu.header= "Select a region"

      BaseMethods.describe_regions.each do | region |
        menu.choice(region){
          @@region = region
          return region
        }
      end

      menu.choice("Exit!"){
        exit
      }
    end
    
  end
  
  def select_instance(region)
    # Select an instance
    @instances = BaseMethods.describe_instance_by_region(region)

    choose do |menu|
      if @instances == []
        menu.prompt = "No instances in this region"
      else
        menu.prompt = "Select an instance"

        @instances.each do | instance |

          hash = {
            :instance_id => instance[:instance_id],
            :status => instance[:instance_state],
            :name => instance[:name],
            :launch_time => instance[:launch_time]
          }

          table = Terminal::Table.new :rows => hash
          menu.choice(table){
            table = Terminal::Table.new :rows => instance
            puts table
            @selected_instance = instance
          }
        end
      end
      menu.choice("Change Regions"){
        BaseMethods.start_over("none")
      }

      menu.choice("Exit!"){
        exit
      }
    end
  end
  
  def instance_action(selected_instance)
    @selected_instance = selected_instance
    # Choose an Action
    choose do | menu |

      menu.prompt = "What would you like to do?"
      unless @selected_instance[:instance_state] == "stopped" || @selected_instance[:instance_state] == "terminated"
        
        #Sets @path_to_keypairs for access
        @path_to_keypairs = StartingConfiguration.path_to_keypair
        menu.choice("SSH"){
            system "ssh -i #{@path_to_keypairs}#{@selected_instance[:keypair]}.pem ec2-user@#{@selected_instance[:ip_address]}"
            BaseMethods.start_over(@@region)
        }
      end
      menu.choice("Refresh"){
        # Actually pull new data
        table = Terminal::Table.new :rows => @selected_instance
        puts table
        # Back to the beginning!
        self.instance_action(selected_instance)
      }

      if @selected_instance[:instance_state] == "running"
        menu.choice("Terminate"){
          choose do | menu2 |
            menu2.header = "Are you sure?"

            menu2.choice("Yes"){
              BaseMethods.instance_action(@selected_instance[:instance_id], "terminate", @@region)
              say("Instance #{@selected_instance[:instance_id]} has been TERMINATED")
              self.instance_action(selected_instance)
            }
            menu2.choice("No"){
              self.instance_action(selected_instance)
            }
          end
        }
        menu.choice("Stop"){
          choose do | menu2 |
            menu2.header = "Are you sure?"
            menu2.choice("Yes"){
              BaseMethods.instance_action(@selected_instance[:instance_id], "stop", @@region)
              say("Instance #{@selected_instance[:instance_id]} has been Stopped")
              self.instance_action(selected_instance)
            }
            menu2.choice("No"){
              self.instance_action(selected_instance)
            }
          end
        }
      elsif @selected_instance[:instance_state] == "stopped"
        menu.choice("Start"){
          BaseMethods.instance_action(@selected_instance[:instance_id], "start", @@region)
          say("Instance #{@selected_instance[:instance_id]} has been STARTED")
          self.instance_action(selected_instance)
        }
        menu.choice("Terminate"){
          choose do | menu2 |
            menu2.header = "Are you sure?"
            menu2.choice("Yes"){
              BaseMethods.instance_action(@selected_instance[:instance_id], "terminate", @@region)
              say("Instance #{@selected_instance[:instance_id]} has been TERMINATED")
              self.instance_action(selected_instance)
            }
            menu2.choice("No"){
              puts "No action taken"
              self.instance_action(selected_instance)
            }
          end
        }
      end
      
      menu.choice("Back to instances in #{@@region}"){
        BaseMethods.start_over(@@region)
      }
      menu.choice("Change Regions"){
        @@region=nil
        BaseMethods.start_over("none")
      }

      menu.choice("Exit!"){
        exit
      }
  end
  end
end