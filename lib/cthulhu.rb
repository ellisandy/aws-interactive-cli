#! /usr/bin/env ruby

require 'rubygems'
require 'highline/import'
# require 'aws-sdk'
# require 'terminal-table'
require '../lib/configuration'
require '../lib/base_methods'
require '../lib/questions'

# Sets the Access Key, Secret key, and Keypair path
configuration = StartingConfiguration.config

BaseMethods.start_over("none")

#TODO Add Elastic Beanstalk Management
#TODO Terminate all "Daily" instances
#TODO Remove SSH if keypair is not given