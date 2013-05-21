#!/usr/bin/env ruby

require File.join(File.expand_path('__FILE__'), '..', 'config', 'environment')
user = User.find(2803)
aspect = Aspect.find(14068)
person = Person.find(3)
allready_contact_of_person_ids = user.contacts.where(:receiving => true).map { |c| c.person.id }

#user.share_with(person, aspect)

#allready_contact_of_person_ids.push user.person.id
Person.where("id NOT IN (?)", allready_contact_of_person_ids).each do |person|
  if person.id >= 40000 && person.id < 42000 && person.closed_account == false && person.url != "https://despora.de/"
    user.share_with(person, aspect)
#    print person.id
#    print " "
  end
#  user.share_with(person)
end
