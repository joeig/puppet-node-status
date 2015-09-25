#!/usr/bin/env ruby
#
# Node status collector

require "json"
require "net/http"
require "uri"

# Usage:
def usage
  puts "USAGE"
  puts "  " + File.basename(__FILE__) + " --dashboard URL [ unresponsive failed pending changed unchanged unreported | --help ]"
end

# Node info generator:
def node_info s, d
  nodes = JSON.parse(Net::HTTP.get(URI.parse(d + "/nodes/" + s + ".json")))

  nodes.each do |node|
    unless node["hidden"]
      puts node["name"] + " - " + s.upcase
      puts "Last report:        " + node["updated_at"]
      puts "Dashboard (node):   " + d + "/nodes/" + node["id"].to_s
      puts "Dashboard (report): " + d + "/reports/" + node["last_apply_report_id"].to_s
      puts
    end
  end
end

# Argument parser:
dashboard_url = ""
status = []

jump = false

ARGV.each_with_index do |arg, i|
  if jump
    jump = false
    next
  end

  case arg
    when "--dashboard"
      dashboard_url = ARGV[i + 1]
      jump = true
    when "unresponsive"
      status << arg
    when "failed"
      status << arg
    when "pending"
      status << arg
    when "changed"
      status << arg
    when "unchanged"
      status << arg
    when "unreported"
      status << arg
    when "--help"
      usage
      exit
    else
      usage
      exit
  end
end

# Validations:
if status.empty?
  status = ["unresponsive", "failed", "pending", "changed", "unchanged", "unreported"]
else
  status.uniq!
end

if dashboard_url.empty?
  usage
  exit
end

# Worker:
status.each do |s|
  node_info s, dashboard_url
end
