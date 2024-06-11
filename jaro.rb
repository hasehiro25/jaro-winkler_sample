require "bundler/setup"
require 'json'
require 'csv'
Bundler.require

HEADER = ["単語1", "単語2", "類似度"].freeze

input = File.read('input.json')
word = JSON.parse(input)['text']

compared_list = []
list = CSV.foreach('list.csv') do |row|
  similarity = JaroWinkler.similarity(word, row.first)
  compared_list << [word, row.first, similarity]
end

CSV.open('output.csv', 'w', headers: true) do |test|
  test << HEADER
  compared_list.each do |item|
    test << item
  end
end

p 'done'

