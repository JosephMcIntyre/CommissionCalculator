# Commission Calculator (Swift, SwiftUI, Realm)
An order tracker, commission calculator, and performance estimator, built in one, designed to help me and my former coworkers better track our commission and performance. My former role was a commission-based sales role at a telecom company. Sales representatives had access to an internal commission tracker that would display monthly payout based on products and services sold and "activated to the network." It also allowed us to see how much more we would need to sell in order to reach a certain payout ("multiplier"). One of my biggest frustrations with this internal tracker was the lack of heavily-requested features, such as not taking into account pending or "backordered" sales, displaying sales needed per day to reach multipliers, slow to update quota relief for paid time off, and a database of completed sales we could reference in case our commission was missing a sale. 

As a result, I built a custom commission calculator that incorporated these ideas for myself and teammates to personally use.

## Overview & Functionality
 
- Basic CRUD operations for manipulating orders
- Workday tab: summary of all orders in current selected workday.
- Tracker tab: summary of all orders in user history. Includes navigation to current month sales, last month sales, next month sales, and chargebacks (returned sales)
- Goals tab: where the magic happens! Sections display current commission payout, multiplier schedule, and current attainment. Values generated here help a user better understand their performance and set goals to achieve a certain payout amount.
- Settings tab: Displays Profile parameters and lets user modify as needed



## Data Modeling
- Three entities were used for data storage. Enum properties were used to categorize orders based on order status and payout status. Functions used to calculate several properties

**Order**
- Attributes used to sort orders include order number, selling day (when order was created), Order Status (enum), and Payout Status (enum).
- Attributes used for order data include phones sold, tablets sold, accessory revenue, home internet, and more.
**MonthData**
- Parent Entity to order. Used to filter orders based on payout status, selling day.
- Contains attributes used for chargeback data.
**Profile**
- Attributes include quota, amount of selling days, PTO for quota relief, and full-time status
- Used to calculate an adjusted quota.
**Goals Tab / Computed Values**
- Used functions to compute most properties
- Commission Section: 
    - Displays both dollar and percentage of total revenue attainment in current month.
    - Calculates commission payout based on at-risk and aformentioned percentage.
- Multiplier Schedule Section
    - Calculates and displays the total needed revenue attainment, remaining needed revenue attainment, and daily revenue attainment needed for six different comission payouts.
- Attainment Section: 
    - Calculates and displays the sum of order data attributes for paid, pending, backordered, prior month, chargebacks, and all orders.

## Technologies & Design

**Swift and SwiftUI**
  - Continued to experiment with SwiftUI for user interface. Entire app made with SwiftUI.
  - Abstracted views as much as possible. Allowed for reusing components such as collapsable section headers.
**Realm**
  - Local database created with Realm for Swift (latest package available)
  - Although I prefer CoreData's seamless integration with CloudKit, first-party nature, Realm was quite pleasant to work with for a simple app. Data models were created as classes and Realm took care of the rest. 
  - Native support for enum attributes shortened development time vs using CoreData, saving raw values as Int/String, and converting to enum in Views
  - Three current entities: Order (individual orders), MonthData (collection of orders, priorMonthOrders, and chargebacks, and Profile (Settings used to calculate quota and commission)
 
**Design**
- Light and Dark mode support
- Support for iPhone & iPad
- Closely-followed Apple Design guidelines for most view components
- Custom collapsable section headers.

## Future Improvements
- Add a higher-level "Months" entity to database to store lists of MonthsData and Profile. This would allow Users to view and edit instances of different comissions (1 per month) instead of resetting the app each month. Could also support automatic loading of prior month orders from a previous instance into current instance (September's next month orders automatically populate in October's prior month orders section)
- Enable syncing with realm for off-device data storage
- Enable Sign in with Apple



