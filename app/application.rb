require 'rack'

class Application

    @@items = [
        Item.new("Apples", 5.23),
        Item.new("Oranges", 2.43)
    ]

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)
            item_name = req.path.split("/items/").last
            found_item = @@items.find {|i| i.name == item_name }
            if found_item
                resp.write found_item.price
            else
                resp.status = 400
                resp.write "Item not found"
            end
        else
            resp.status = 404
            resp.write "Route not found"
        end

        resp.finish
    end

end