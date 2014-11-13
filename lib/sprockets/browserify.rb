require 'sprockets'
require 'tilt'
require 'pathname'
require 'shellwords'

module Sprockets
  # Postprocessor that runs the computed source of Javascript files
  # through browserify, resulting in a self-contained files including all
  # referenced modules
  class Browserify < Tilt::Template

    def prepare
    end

    def evaluate(scope, locals, &block)
      if (scope.pathname.dirname+'package.json').exist?
        deps = `#{browserify_executable} --list #{scope.pathname}`
        unless $?.success?
          puts deps
          raise "Error finding dependencies"

        end

        deps.lines.drop(1).each{|path| scope.depend_on path.strip}

        output ||= `#{browserify_executable} -d #{scope.pathname}`
        unless $?.success?
          puts output
          raise "Error compiling dependencies"
        end

        output
      else
        data
      end
    end

  protected

    def gem_dir
      @gem_dir ||= Pathname.new(__FILE__).dirname + '../..'
    end

    def browserify_executable
      @browserify_executable ||= gem_dir + 'node_modules/browserify/bin/cmd.js'
    end

  end
end
