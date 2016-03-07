require('pg')
require( 'pry-byebug' )

class Shop 
  attr_reader :name, :address, :id, :stock_kind
  @@db_credentials = { dbname: 'petshop', host: 'localhost' }

  def initialize(options) 
    @name = options["name"]
    @address = options["address"] 
    @stock_kind=options["stock_kind"]   
    @id = options["id"] or nil
  end

  def pets()
    sql = "SELECT * FROM pets WHERE shop_id=#{@id} ORDER BY name"
    pets = Shop.run_sql(sql)
    result = pets.map { |pet| Pet.new(pet) } 
  end

  def self.all()
    sql = "SELECT * FROM shops ORDER BY name"
    shops = Shop.run_sql( sql )
    result = shops.map { |shop| Shop.new(shop) } 
  end

  def save()
    sql = "INSERT INTO shops ( 
      name, 
      address,
      stock_kind
      ) 
      VALUES (
      '#{ @name }',
      '#{ @address }',
      '#{@stock_kind}'
      )"
    return Shop.run_sql( sql )
  end

  def self.find(id)
   sql = "SELECT * FROM shops WHERE id = #{id.to_i}"
   result = Shop.run_sql( sql )
   shop = Shop.new( result[0] )
  end

  def update()
    sql = "UPDATE shops SET name='#{ @name }', address='#{ @address }', stock_kind='#{stock_kind}' WHERE id = #{@id}"
    return Shop.run_sql( sql )
  end

  def self.destroy(id)
    Shop.run_sql("DELETE FROM shops WHERE id=#{id}")
  end

  private 

  def self.run_sql( sql )
    begin
      db = PG.connect( @@db_credentials )
      result = db.exec( sql )
    ensure
      db.close
    end
    return result
  end

end
