require_relative("../db/SqlRunner.rb")

class Ticket

  attr_reader :id, :film_id, :customer_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id'].to_i
    @customer_id = options['customer_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets (film_id, customer_id) VALUES ($1, $2) RETURNING id"
    values = [@film_id, @customer_id]
    ticket = SqlRunner.run(sql, values)[0];
    @id = ticket['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end






end
