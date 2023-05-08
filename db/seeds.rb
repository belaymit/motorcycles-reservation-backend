# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

first_user = User.create(name: 'Random User', email: 'randomuser@gmail.com', password: '123456',
  password_confirmation: '123456')
second_user = User.create(name: 'Another User', email: 'anotheruser@gmail.com', password: '123456',
  password_confirmation: '123456')
third_user = User.create(name: 'Belay Birhanu', email:'belay@gmail.com', password: '123456', password_confirmation: '123456' )

  first_vehicle = Motorcycle.create(
    name: 'Gas Scooter Moped Bike', 
    image: 'https://image.made-in-china.com/155f0j00qfhUtJVGTauL/Vespa-Type-125cc-Gas-Scooter-Moped-Bike.jpg', 
    description: 'Vespa is an Italian luxury brand of scooters and mopeds manufactured by Piaggio
                The name means wasp in Italian. The Vespa has evolved from a single model motor scooter
                manufactured in 1946 by Piaggio & Co. S.p.A. of Pontedera, Italy to a full l
                ine of scooters and one of seven companies today owned by Piaggio', 
    price: 12000, 
    category: 'Vespa 50cc')

    second_vehicle = Motorcycle.create(
      name: 'Vespa Scooter-Authotrader', 
      image: 'https://1.cdn.autotraderspecialty.com/Article-1000000003-5ca78614aab09bd072e32f2bc9373a3b.jpg', 
      description: 'From their inception, Vespa scooters have been known for their painted, pressed steel 
                    unibody which combines, in a unified structural unit, a complete cowling for the engine
                   (enclosing the engine mechanism and concealing dirt or grease), a flat floorboard 
                   (providing foot protection), and a prominent front fairing (providing wind protection).', 
      price: 4000, 
      category: 'Vespa 125cc')

      third_vehicle = Motorcycle.create(
        name: 'Vespa 75', 
        image: 'https://www.cycleworld.com/resizer/G7kh2dY7Ijq60_prXekfBv92jUE=/1440x0/smart/cloudfront-us-east-1.images.arcpublishing.com/octane/74P3WEDWJBBC7BVZV7RBEZFFQU.jpg', 
        description: 'Italy has given the world countless beauty icons: actresses, 
                    great paintings, cathedrals, and some of the most gorgeous motor 
                    vehicles in the world. Today most motorcyclists think of Ducati 
                    when it comes to sexy bodywork, but it’s arguably little Vespa that deserves the credit.', 
        price: 1000, 
        category: 'Vespa 75cc')
      
Reservation.create(user_id: first_user.id,motorcycle_id: first_vehicle.id,start_date: '2023-05-05', end_date: '2023-05-18')
Reservation.create(user_id: second_user.id,motorcycle_id: first_vehicle.id,start_date: '2023-06-10', end_date: '2023-05-24')