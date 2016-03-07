require('pg')

class Pet
  attr_reader :name, :shop_id, :id, :species, :photo

  @@db_credentials = { dbname: 'petshop', host: 'localhost' }

  def initialize(options) 
    @name = options["name"]
    @shop_id = options["shop_id"]
    @species=options["species"]
    @id = options["id"] or nil
    @photo=options["photo"]
  end

  def shop()
    sql = "SELECT * FROM shops WHERE id = #{@shop_id}"
    result = Pet.run_sql( sql )
    Shop.new( result[0] )
  end

  def save()
    sql = "INSERT INTO pets ( 
      name,
      species,
      shop_id,
      photo) 
      VALUES (
      '#{ @name }',
      '#{ @species }',
      '#{ @shop_id }',
      '#{ @photo }'
      )"
    Pet.run_sql( sql )
  end

  def self.all()
    sql = "SELECT * FROM pets ORDER BY name"
    pets = Pet.run_sql( sql )
    result = pets.map { |pet| Pet.new(pet) } 
  end

  def self.find(id)
   sql = "SELECT * FROM pets WHERE id = #{id.to_i}"
   result = Pet.run_sql( sql )
   return Pet.new( result[0] )
  end

  def update()
    sql = "UPDATE pets SET name='#{ @name }', species='#{@species}', shop_id = #{ @shop_id }, photo='#{@photo}' WHERE id = #{@id}"
    return Pet.run_sql( sql )
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