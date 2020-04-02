require 'csv'
require 'open-uri'

namespace :import do
  task run: :environment do
    data = open('https://raw.githubusercontent.com/TheEconomist/big-mac-data/master/output-data/big-mac-full-index.csv')
    imported = 0

    CSV.foreach(data, headers: true) do |row|
      index = BigMacIndex.where(date: row['date'], iso_a3: row['iso_a3']).first_or_initialize
      index.assign_attributes(row.to_hash)
      
      if index.save
        imported += 1
      else
        puts "#{row['date']} - #{row['iso_a3']} - #{index.errors.full_messages.join(',')}"
      end
    end
    puts "#{imported} records imported."
  end
end
