DatabaseCleaner.clean_with :truncation

Car.create! levels: [3]      , description: "Audi A3 Sportback S line 1.8 TFSI 6 speed", price_cents: 3400000
Car.create! levels: [2,3]    , description: "Audi A4 Avant Black Edition 2.0 TDI multitronic ", price_cents: 3200000
Car.create! levels: [1]      , description: "Audi Q7 S line Sport Edition 3.0 TDI quattro tiptronic", price_cents: 7000000
Car.create! levels: [1]      , description: "Audi S8 4.0 TFSI quattro tiptronic ", price_cents: 9300000
Car.create! levels: [2,3]    , description: "BMW 220i Coupé Steptronic ", price_cents: 3200000
Car.create! levels: [1,2, 3] , description: "BMW 328i Touring ", price_cents: 4200000
Car.create! levels: [1,2, 3] , description: "BMW X5 sDrive25d ", price_cents: 5500000
Car.create! levels: [2,3]    , description: "VW Golf Variant TDI BlueMotion Comfortline ", price_cents: 2370000
Car.create! levels: [1,2,3]  , description: "VW Passat Trendline 2.0 TDI BlueMotion ", price_cents: 3130000
Car.create! levels: [1,2, 3] , description: "Mercedes E 220 BlueTEC Limousine ", price_cents: 4412000
Car.create! levels: [1]      , description: "Mercedes E 500 4MATIC Limousine ", price_cents: 7363100
Car.create! levels: [1]      , description: "Mercedes S 300 BlueTEC HYBRID Limousine ", price_cents: 8092000


User.create! email: "l1@mycars.com", password: 'secret', level: 1, permission: true
User.create! email: "l2@mycars.com", password: 'secret', level: 2, permission: true
User.create! email: "l3@mycars.com", password: 'secret', level: 3, permission: true
User.create! email: "l0@mycars.com", password: 'secret', level: 0, permission: false

