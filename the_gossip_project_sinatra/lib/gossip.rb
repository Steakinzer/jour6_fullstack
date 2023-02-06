# require 'pry'
require 'csv'

class Gossip
  attr_accessor :content, :author

  def initialize(content, author)
    @content = content
    @author = author
  end

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@content, @author]
    end
  end

  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips
  end

  def self.find(id)
    p self.all[id]
  end

  # def self.test
  #    test = self.all[1] 
  #    p test
  #    p test.find_index('2')
  # end

  def self.edit(new_author, new_content)
     new_gossip = self.all
     new_gossip[1] = Gossip.new(new_author, new_content)
     CSV.foreach("./db/gossip.csv") do |row|
      clean_row = row.map! {|field| field = ""}
      row << clean_row
     end
    i=0
    new_gossip.each do    
      CSV.open("./db/gossip.csv", "a+") do |csv|

       csv << [new_gossip[i].author, new_gossip[i].content]
       i +=1
      end
    end
  end
   
  # def save2
  #   new_gossip.each do
  #   CSV.open("./db/gossip.csv", "ab") do |csv|
  #     csv << [@author, @content]
  #   end
  # end
# end

end


# binding.pry
