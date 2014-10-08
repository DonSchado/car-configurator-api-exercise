# Exercise: Company car order for employees

A company wants to supply company cars for employees in various management positions. With a leasing company, an agreement was concluded to cover financing, insurance, claims management and fuel card handling. The company offers its employees advance calculated vehicle configurations, which can be supplemented by staff to individual equipment details.

The appointment of a company car to the employee can perform on a surface that is to be integrated into the existing smartphone app of the company and website.

### Write the backend (JSON API) wich can perform the following scenarios:

The website needs authentication using email and password, which additionally checks for the "company car entitlement" (permission) and management level.

An employee with a company car entitlement belongs to a management level (Level 1, Level 2, Level 3) and can select from vehicles / service packages that are assigned to one of the assigned levels.

At the end the employee receives a list of the configured vehicle with a listing of completed services. He can then order, with a delivery address and a car dealership must be selected during the ordering process, over which the vehicle is ordered.

After ordering, the employee will receive a confirmation (i.e. by e-mail). This confirmation is listed:
  * Date of the order / order
  * Vehicle
  * Service package
  * Lease rate + (optional) own contribution
  * The lease term and KM mileage
  * Autohaus
  * Expected date of delivery - Delivery address

The employee can check the  status of an order

#### Management Levels:
  * Level 1 - upper management (limit. € 1200 lease rate / month)
  * Level 2 - middle management (limit: 800 € lease rate / month.)
  *￼ Level 3 - lower management (limit: 600 € lease rate / month.)

#### Vehicles for corresponding levels where [1,2] => level 1, level 2
  * [3] Audi A3 Sportback S line 1.8 TFSI 6 speed (€ 34,000)
  * [2,3] Audi A4 Avant 2.0 TDI multitronic Black Edition (€ 32,000)
  * [1] Audi Q7 S line Sport Edition 3.0 TDI quattro tiptronic (€ 70,000)
  * [1] Audi S8 4.0 TFSI quattro tiptronic (€ 93,000)
  * [2,3] BMW 220i Coupe Steptronic (€ 32,000)
  * [1,2,3] BMW 328i Touring (€ 42,000)
  * [1,2,3] BMW X5 sDrive25d (€ 55,000)
  * [2,3] VW Golf Variant TDI BlueMotion Comfortline (€ 23,700)
  * [1,2,3] VW Passat Trendline 2.0 TDI BlueMotion (€ 31,300)
  * [1,2,3] Mercedes E 220 BlueTEC sedan (€ 44,120)
  * [1] Mercedes E 500 4MATIC Sedan (€ 73,631)
  * [1] Mercedes S 300 BlueTEC HYBRID sedan (€ 80,920)

#### Lease duration:

  The lease rate is calculated based on the vehicle configuration (list price), the lease duration and distance-running performance, taking into account interest rates, risk classes and much more. To calculate the configuration data is sent to the spreadsheet, which then calculates the lease rate.
  For this functionality, a mock service is provided which calculates the lease rate. This query expects three parameters (price - the list price of the vehicle in Euros, kilometers - the mileage in km and period - the lease term in months) and are either the price as JSON back or an array of errors.

  Example Call:
  ``` http://leasing-rate calculator.herokuapp.com/?price=60000&period=48&kilometers=80000```

  It returns an error if the lease term or period not correspond to a valid value:

  * 10,000 km | 20,000 km | 40,000 km | 50,000 km | 80,000 km | 120,000 km
  * 24 months | 36 months | 48 months

#### Service packages:
  Level 1 and 2 have both packages to choose from, at Level 3 Package 1 is always included.
  It can be selected only one package.

  * Package 1:
    * Claims Management Plus
    * pick up and delivery service
    * car rental services
    * free workshop selection
    * fuel card


  * Package 2:
    * Damage Management Plus
    * Pcik up and delivery service
    * partner workshop
    * Fuel Card

#### Dealerships is where ordered

  * Autohaus Adam
  * Autohaus minor
  * Autohaus Peters
  * Huddel & Brassel KG awareness
  * Meier GmbH & Co. KG


# Good Luck!
