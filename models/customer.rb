require_relative("../db/SqlRunner.rb")
require_relative("film.rb")
require_relative("ticket.rb")


class Customer

  attr_reader :id, :name
  attr_accessor :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values)[0];
    @id = customer['id'].to_i
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customer_data = SqlRunner.run(sql)
    return Customer.map_items(customer_data)
  end

  def self.map_items(data)
    result = data.map { |customer| Customer.new(customer) }
    return result
  end

  def films()
    sql = "SELECT films.* FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE customer_id = $1"
    values = [@id]
    film_data = SqlRunner.run(sql, values)
    return Film.map_items(film_data)
  end

  def pay(film)
    film.price -= @funds
  end

  def number_of_tickets()
    sql = "SELECT tickets.* FROM customers
    INNER JOIN tickets
    ON customers.id = tickets.customer_id
    WHERE customer_id = $1;"
    values = [@id]
    tickets_data = SqlRunner.run(sql, values)
    tickets_array = Ticket.map_items(tickets_data)
    return tickets_array.count
  end





end
