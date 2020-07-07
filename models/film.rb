require_relative("../db/sql_runner")

class Film

    attr_reader :id
    attr_accessor :title, :price

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @title = options['title']
        @price = options['price'].to_i
    end

    def save()
        sql = "INSERT INTO films
        (title, price) 
        VALUES
        ($1, $2) RETURNING id"
        values = [@title, @price]
        result = SqlRunner.run(sql, values).first
        @id = result['id'].to_i
    end

    def self.delete_all()
        sql = "DELETE FROM films"
        SqlRunner.run(sql)
    end

    def delete()
        sql = "DELETE FROM films
        WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    def self.all()
        sql = "SELECT * from films"
        film_list = SqlRunner.run(sql)
        return Film.map_items(film_list)
    end

    def update()
        sql = "UPDATE films
        SET (title, price)
        = ($1, $2)
        WHERE id = $3"
        values = [@title, @price, @id]
        SqlRunner.run(sql, values)
    end

    def customers()
        sql = "SELECT customers.* FROM customers
        INNER JOIN tickets ON
        tickets.customer_id = customers.id
        INNER JOIN screenings ON
        tickets.screening_id = screenings.id
        WHERE screenings.film_id = $1"
        values = [@id]
        customers = SqlRunner.run(sql, values)
        return Customer.map_items(customers)
    end

    def screenings()
        sql = "SELECT * FROM screenings
        WHERE film_id = $1"
        values = [@id]
        screening_data = SqlRunner.run(sql, values)
        return Screening.map_items(screening_data)
    end

    def tickets()
        sql = "SELECT tickets.*
        FROM tickets
        INNER JOIN screenings
        ON tickets.screening_id = screenings.id
        WHERE screenings.film_id = $1"
        values = [@id]
        ticket_data = SqlRunner.run(sql, values)
        return Ticket.map_items(ticket_data)
    end

    def self.find_by_id(id)
        sql = "SELECT * FROM films
        WHERE id = $1"
        values = [id]
        result = SqlRunner.run(sql, values)
        found_film = self.new(result.first)
        return found_film
    end

    def self.map_items(data)
        return data.map { |film| Film.new(film) }
    end

    def num_customers()
        return customers.count()
    end

end