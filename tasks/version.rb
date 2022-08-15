#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'

module Taiga
  class SoftwarePart
    attr_reader :latest_stable_version, :current_version

    def initialize(directory)
      @directory = directory

      Dir.chdir @directory do
        @latest_stable_version = `git describe --tags origin/stable`.chomp
        @version = `git describe --tags`.chomp
      end
    end

    def upgradable?
      Gem::Version.new(@latest_stable_version) > Gem::Version.new(@version)
    end

    def to_h
      {
        version: @version,
        latest_stable_version: @latest_stable_version,
        upgradable: upgradable?,
      }
    end
  end
end

params = JSON.parse($stdin.read)

backend = Taiga::SoftwarePart.new(params['backend_directory'])
frontend = Taiga::SoftwarePart.new(params['frontend_directory'])

hash = {
  taiga: {
    backend: backend.to_h,
    frontend: frontend.to_h,
    upgradable: backend.upgradable? || frontend.upgradable?
  },
}

puts hash.to_json
