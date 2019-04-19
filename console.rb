require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')

require('pry-byebug')


Customer.delete_all()
Ticket.delete_all()
Film.delete_all()

  film1 = Film.new({
    'title' => 'In Bruges',
    'price' => 7
    })

  film2 = Film.new({
    'title' => 'The Station Agent',
    'price' => 10
    })

    film1.save()
    film2.save()

  customer1 = Customer.new({
    'name' => 'Jessica',
    'funds' => 15
    })

  customer2 = Customer.new({
    'name' => 'Lewis',
    'funds' => 32
    })

  customer3 = Customer.new({
    'name' => 'Fred',
    'funds' => 8
    })

    customer1.save()
    customer2.save()
    customer3.save()

  ticket1 = Ticket.new({
    'film_id' => film2.id,
    'customer_id' => customer1.id
    })

  ticket2 = Ticket.new({
    'film_id' => film2.id,
    'customer_id' => customer2.id
    })

  ticket3 = Ticket.new({
    'film_id' => film1.id,
    'customer_id' => customer3.id
    })

  ticket4 = Ticket.new({
    'film_id' => film1.id,
    'customer_id' => customer1.id
    })

    ticket1.save()
    ticket2.save()
    ticket3.save()
    ticket4.save()

    # p Customer.all()
    # p Film.all()
    # p Ticket.all()

    # p customer1.films()
    # p film1.customers()

    customer1.pay(film2)
    customer1.update()

    # p customer1.funds

    p customer1.number_of_tickets
    p customer2.number_of_tickets
