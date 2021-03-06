require_relative("../db/SqlRunner.rb")

class Film

  attr_accessor :price
  attr_reader :id, :title


  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values)[0];
    @id = film['id'].to_i
  end

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end


  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM films"
     film_data = SqlRunner.run(sql)
    return Film.map_items(film_data)
  end

  def self.map_items(data)
    result = data.map { |film| Film.new(film) }
    return result
  end

  def customers()
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE film_id = $1"
    values = [@id]
    customer_data = SqlRunner.run(sql, values)
    return Customer.map_items(customer_data)
  end

  def number_of_customers()
    # sql = "SELECT customers.* FROM films
    # INNER JOIN tickets
    # ON customers.id = tickets.customer_id
    # INNER JOIN customers
    # ON tickets.film_id = films.id
    # WHERE film_id = $1;"
    # values = [@id]
    # customer_data = SqlRunner.run(sql, values)
    # customer_array = Customer.map_items(customer_data)
    # return customer_array.count
    return customers.count
  end




end
