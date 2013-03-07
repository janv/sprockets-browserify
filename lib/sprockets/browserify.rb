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
        deps = `NODE_PATH=#{Shellwords.shellescape((gem_dir+'node_modules').to_s)} node -e "mdeps=require('module-deps'),through=require('through');mdeps('#{scope.pathname}').pipe(through(function(d){ console.log(d.id); }))"`
        deps.lines.reject{|line| line =~ /module-deps/}.drop(1).each{|path| scope.depend_on path.strip}
        # TODO also throw an error if browserify fucks up
        @output ||= `#{browserify_executable} -d #{scope.pathname}`
      else
        data
      end
    end

  protected

    def gem_dir
      @gem_dir ||= Pathname.new(__FILE__).dirname + '../..'
    end

    def browserify_executable
      @browserify_executable ||= gem_dir + 'node_modules/.bin/browserify'
    end

  end
end
