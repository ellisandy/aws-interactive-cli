# AWSInteractiveCLI

#TODO Add Elastic Beanstalk Management
#TODO Terminate all "Daily" instances
#TODO Remove SSH if keypair is not given

## Installation

Run the following command to install the AWSInstanceCLI

    gem install 'aws_interactive_cli'

## Usage

The first time you run the aws_interactive_cli the program checks for ~/.aws-config.yml. If the file is not found the program will ask for your access key, secret key, and the path to your keypair. Provided that you are executing this program on an instance and do not have access to your keypairs, the script will automatically disable the "SSH" functionality. All other functionality (should) still work.

Please report bugs you are seeing (or even better--debug them yourself), so this can become an easy, useful tool. 

Feedback and feature requests are welcome

Enjoy!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
