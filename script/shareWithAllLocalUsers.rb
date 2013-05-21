#!/usr/bin/env ruby

require File.join(File.expand_path('__FILE__'), '..', 'config', 'environment')
user = User.find(31)
aspect = Aspect.find(79)
to_be_excluded_person_ids = user.contacts.where(:sharing => true).map { |c| c.person.id }
to_be_excluded_person_ids.push user.person.id
Person.where(Person.arel_table[:id].not_in(to_be_excluded_person_ids)).where("diaspora_handle LIKE '%@despora.de'").where("created_at > 2012-10-06").each do |person|
  begin
    user.share_with(person, aspect)
  rescue
    p "Kein Error: #{$!.message}"
  end
end
