# encoding: UTF-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

f = open('db/seeds.txt')
while not f.eof
	l = f.readline
	a = l.split "\t"
	Wormhole.create(name: a[0], cls: a[1].to_i, climate: a[2], scs: a[3].split)
end

f = open('db/mcx.txt')
h = f.readline.split "\t"
i = 0
while not f.eof
  i += 1
  a = f.readline.split "\t"
  cl = Climate.create(name: "脉冲星", cls: i)
  8.times do |j|
    cl.affects.push(h[j]+' : '+a[j])
  end
  cl.save
end

f = open('db/hd.txt')
h = f.readline.split "\t"
i = 0
while not f.eof
  i += 1
  a = f.readline.split "\t"
  cl = Climate.create(name: "黑洞", cls: i)
  6.times do |j|
    cl.affects.push(h[j]+' : '+a[j])
  end
  cl.save
end

f = open('db/jbbx.txt')
h = f.readline.split "\t"
i = 0
while not f.eof
  i += 1
  a = f.readline.split "\t"
  cl = Climate.create(name: "激变变星", cls: i)
  6.times do |j|
    cl.affects.push(h[j]+' : '+a[j])
  end
  cl.save
end

f = open('db/cx.txt')
h = f.readline.split "\t"
i = 0
while not f.eof
  i += 1
  a = f.readline.split "\t"
  cl = Climate.create(name: "磁星", cls: i)
  11.times do |j|
    cl.affects.push(h[j]+' : '+a[j])
  end
  cl.save
end


f = open('db/wefly.txt')
h = f.readline.split "\t"
i = 0
while not f.eof
  i += 1
  a = f.readline.split "\t"
  cl = Climate.create(name: "沃尔夫-拉叶星", cls: i)
  4.times do |j|
    cl.affects.push(h[j]+' : '+a[j])
  end
  cl.save
end



f = open('db/hjx.txt')
h = f.readline.split "\t"
i = 0
while not f.eof
  i += 1
  a = f.readline.split "\t"
  cl = Climate.create(name: "红巨星", cls: i)
  4.times do |j|
    cl.affects.push(h[j]+' : '+a[j])
  end
  cl.save
end


