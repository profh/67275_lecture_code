class Duck
  def talk; p 'quack'; end
  # alias :quack :talk
  alias_method :quack, :talk
end

d = Duck.new
d.talk          # => "quack"
d.quack         # => "quack"

p d.send :public_methods, false






## ------------------
# Using aliases to revise methods
class String
  alias :original_length :length
  
  def length
    original_length > 5 ? 'long' : 'short'
  end
end

"War and Peace".length            # => "long"
"War and Peace".original_length   # => 13

# Example from 67-272
class Fixnum
  alias_method :original_to_s, :to_s
  def to_s
    case
    when (self%15)==0 then 'fizzbuzz'
    when (self%3)==0 then 'fizz'
    when (self%5)==0 then 'buzz'
    else original_to_s
    end
  end
end

puts
p (1..100).to_a 