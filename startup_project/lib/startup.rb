require "employee"

class Startup
    attr_reader :name, :funding, :salaries, :employees

    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = Array.new
    end

    def valid_title?(title)
        if salaries.keys.include?(title)
            return true
        else
            return false
        end
    end

    def > (startup)
        if self.funding > startup.funding
            return true
        else
            return false
        end
    end

    def hire(name, title)
        if valid_title?(title)
            @employees << Employee.new(name, title)
        elsif valid_title?(title) == false
            raise 'Not valid title.'
        end
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        pay_amt = @salaries[employee.title]
        if @funding >= pay_amt
            employee.pay(pay_amt)
            @funding -= pay_amt
        else
            raise 'not enough pylons, make more pylons'
        end
    end

    def payday
        @employees.each do |emp|
            pay_employee(emp)
        end
    end

    def average_salary
        sum = 0
        @employees.each do |em|
            sum += @salaries[em.title]
        end
        
        sum / @employees.length
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(startup)
        @funding += startup.funding
        startup.salaries.each do |title, salary|
            if !self.salaries.keys.include?(title)
                self.salaries[title] = salary
            end
        end
        @employees += startup.employees
        startup.close # :(
    end

end
