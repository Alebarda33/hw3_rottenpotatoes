# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    m = Movie.create(movie)
  end
  #assert false, "Unimplmemented"
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  #puts page.body
  #puts Movie.count
  e1_idx = page.body.index(e1)
  e2_idx = page.body.index(e2)
  #debugger
  assert(e1_idx < e2_idx, "order wrong")
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
   rating_list.split(", ").each do |value|
      if uncheck == "un"
        step %Q{I uncheck "ratings[#{value}]"}
      else
        step %Q{I check "ratings[#{value}]"}
      end
   end
end

Then /I should( not)? see all of the movies/ do |negate|
  expectation = negate ? 0 : Movie.count 
  got = page.all("table#movies tr").count-1 # one row subtracted because of header has same <tr> tag
  #puts page.body
  assert(got== expectation, "Wrong number of rows: expected #{expectation}, got #{got}")
end
