#!/usr/bin/env ruby

# Delete tags from the local Git repository, which are not found on
# a remote origin
#
# Usage: git sync-local-tags [-n]
#        if -n is passed, just print the tag to be deleted, but do not
#        actually delete it.
#
# Author: Konstantin Gredeskoul (http://tektastic.com)
#
# I pulled this in since the repo no longer exists here:
#
# https://github.com/kigster/git_scripts
#
#######################################################################

class TagSynchronizer
  def self.local_tags
    `git show-ref --tags | awk '{print $2}'`.split(/\n/)
  end

  def self.remote_tags
    `git ls-remote --tags origin | awk '{print $2}'`.split(/\n/)
  end

  def self.orphaned_tags
    self.local_tags - self.remote_tags
  end

  def self.remove_unused_tags(print_only = false)
    self.orphaned_tags.each do |ref|
      tag = ref.gsub /refs\/tags\//, ''
      puts "deleting local tag #{tag}"
      `git tag -d #{tag}` unless print_only
    end
  end
end

unless File.exists?(".git")
  puts "This doesn't look like a git repository."
  exit 1
end

print_only = ARGV.include?("-n")
TagSynchronizer.remove_unused_tags(print_only)
