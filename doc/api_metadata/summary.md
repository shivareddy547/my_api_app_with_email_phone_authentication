# API Documentation Summary

Generated: 2026-03-d 18:41:21

## Statistics
- Total Models: 11
- Total Controllers: 11
- Total Serializers: 8
- Total Helpers: 0
- Total Routes: 52
- Total Endpoints: 52
- New Endpoints: 0
- Modified Endpoints: 9

## File Paths

### Controllers:
- `application`: `app/controllers/application_controller.rb`
- `floors`: `app/controllers/api/floors_controller.rb`
- `categories`: `app/controllers/api/categories_controller.rb`
- `tables`: `app/controllers/api/tables_controller.rb`
- `menu_items`: `app/controllers/api/menu_items_controller.rb`
- `orders`: `app/controllers/api/orders_controller.rb`
- `reports`: `app/controllers/api/reports_controller.rb`
- `payments`: `app/controllers/api/payments_controller.rb`
- `staff_members`: `app/controllers/api/staff_members_controller.rb`
- `contacts`: `app/controllers/api/contacts_controller.rb`
- `auth`: `app/controllers/api/auth_controller.rb`

### Models:
- `payment`: `{'path': 'app/models/payment.rb', 'attributes': {'created_at': {'type': 'string', 'format': 'date-time', 'description': 'Creation timestamp'}, 'updated_at': {'type': 'string', 'format': 'date-time', 'description': 'Update timestamp'}}}`
- `category`: `{'path': 'app/models/category.rb', 'attributes': {'created_at': {'type': 'string', 'format': 'date-time', 'description': 'Creation timestamp'}, 'updated_at': {'type': 'string', 'format': 'date-time', 'description': 'Update timestamp'}}}`
- `contact`: `{'path': 'app/models/contact.rb', 'attributes': {'created_at': {'type': 'string', 'format': 'date-time', 'description': 'Creation timestamp'}, 'updated_at': {'type': 'string', 'format': 'date-time', 'description': 'Update timestamp'}}}`
- `order_item`: `{'path': 'app/models/order_item.rb', 'attributes': {'created_at': {'type': 'string', 'format': 'date-time', 'description': 'Creation timestamp'}, 'updated_at': {'type': 'string', 'format': 'date-time', 'description': 'Update timestamp'}}}`
- `table`: `{'path': 'app/models/table.rb', 'attributes': {'created_at': {'type': 'string', 'format': 'date-time', 'description': 'Creation timestamp'}, 'updated_at': {'type': 'string', 'format': 'date-time', 'description': 'Update timestamp'}}}`
- `staff_member`: `{'path': 'app/models/staff_member.rb', 'attributes': {'created_at': {'type': 'string', 'format': 'date-time', 'description': 'Creation timestamp'}, 'updated_at': {'type': 'string', 'format': 'date-time', 'description': 'Update timestamp'}}}`
- `floor`: `{'path': 'app/models/floor.rb', 'attributes': {'created_at': {'type': 'string', 'format': 'date-time', 'description': 'Creation timestamp'}, 'updated_at': {'type': 'string', 'format': 'date-time', 'description': 'Update timestamp'}}}`
- `jwt_denylist`: `{'path': 'app/models/jwt_denylist.rb', 'attributes': {'created_at': {'type': 'string', 'format': 'date-time', 'description': 'Creation timestamp'}, 'updated_at': {'type': 'string', 'format': 'date-time', 'description': 'Update timestamp'}}}`
- `order`: `{'path': 'app/models/order.rb', 'attributes': {'created_at': {'type': 'string', 'format': 'date-time', 'description': 'Creation timestamp'}, 'updated_at': {'type': 'string', 'format': 'date-time', 'description': 'Update timestamp'}}}`
- `menu_item`: `{'path': 'app/models/menu_item.rb', 'attributes': {'created_at': {'type': 'string', 'format': 'date-time', 'description': 'Creation timestamp'}, 'updated_at': {'type': 'string', 'format': 'date-time', 'description': 'Update timestamp'}}}`
- `user`: `{'path': 'app/models/user.rb', 'attributes': {'created_at': {'type': 'string', 'format': 'date-time', 'description': 'Creation timestamp'}, 'updated_at': {'type': 'string', 'format': 'date-time', 'description': 'Update timestamp'}}}`

### Serializers:
- `table`: `app/serializers/table_serializer.rb`
- `floor`: `app/serializers/floor_serializer.rb`
- `order`: `app/serializers/order_serializer.rb`
- `contact`: `app/serializers/contact_serializer.rb`
- `menu_item`: `app/serializers/menu_item_serializer.rb`
- `order_item`: `app/serializers/order_item_serializer.rb`
- `category`: `app/serializers/category_serializer.rb`
- `payment`: `app/serializers/payment_serializer.rb`

### Helpers:

### Model Attributes Summary:

#### payment
- `created_at`: string
- `updated_at`: string

#### category
- `created_at`: string
- `updated_at`: string

#### contact
- `created_at`: string
- `updated_at`: string

#### order_item
- `created_at`: string
- `updated_at`: string

#### table
- `created_at`: string
- `updated_at`: string

#### staff_member
- `created_at`: string
- `updated_at`: string

#### floor
- `created_at`: string
- `updated_at`: string

#### jwt_denylist
- `created_at`: string
- `updated_at`: string

#### order
- `created_at`: string
- `updated_at`: string

#### menu_item
- `created_at`: string
- `updated_at`: string

#### user
- `created_at`: string
- `updated_at`: string

### Endpoints by Controller:

#### ContactsController (1 endpoints)
- `POST /api/contacts` -> `ContactsController#create`
  - Serializers: contact
  - Model attributes: created_at, updated_at...

#### AuthController (9 endpoints)
- `POST /api/auth/signup` -> `AuthController#signup`
- `POST /api/auth/login` -> `AuthController#login`
- `POST /api/auth/otp_login` -> `AuthController#otp_login`
- `POST /api/auth/verify_otp` -> `AuthController#verify_otp`
- `POST /api/auth/refresh` -> `AuthController#refresh`
- `DELETE /api/auth/logout` -> `AuthController#logout`
- `GET /api/auth/me` -> `AuthController#me` (✏️ MODIFIED)
- `POST /api/auth/password/forgot` -> `AuthController#forgot_password`
- `POST /api/auth/password/reset` -> `AuthController#reset_password`

#### MenuItemsController (6 endpoints)
- `GET /api/menu_items` -> `MenuItemsController#index` (✏️ MODIFIED)
  - Serializers: menu_item
  - Model attributes: created_at, updated_at...
- `POST /api/menu_items` -> `MenuItemsController#create`
  - Serializers: menu_item
  - Model attributes: created_at, updated_at...
- `PUT /api/menu_items/{id}` -> `MenuItemsController#update`
  - Serializers: menu_item
  - Model attributes: created_at, updated_at...
- `PATCH /api/menu_items/{id}` -> `MenuItemsController#update`
  - Serializers: menu_item
  - Model attributes: created_at, updated_at...
- `DELETE /api/menu_items/{id}` -> `MenuItemsController#destroy`
  - Serializers: menu_item
  - Model attributes: created_at, updated_at...
- `PATCH /api/menu_items/{id}/availability` -> `MenuItemsController#availability`
  - Serializers: menu_item
  - Model attributes: created_at, updated_at...

#### CategoriesController (3 endpoints)
- `GET /api/categories` -> `CategoriesController#index` (✏️ MODIFIED)
- `POST /api/categories` -> `CategoriesController#create`
- `DELETE /api/categories/{id}` -> `CategoriesController#destroy`

#### OrdersController (6 endpoints)
- `GET /api/orders` -> `OrdersController#index` (✏️ MODIFIED)
  - Serializers: order
  - Model attributes: created_at, updated_at...
- `GET /api/orders/{id}` -> `OrdersController#show` (✏️ MODIFIED)
  - Serializers: order
  - Model attributes: created_at, updated_at...
- `POST /api/orders` -> `OrdersController#create`
  - Serializers: order
  - Model attributes: created_at, updated_at...
- `PUT /api/orders/{id}` -> `OrdersController#update`
  - Serializers: order
  - Model attributes: created_at, updated_at...
- `PATCH /api/orders/{id}` -> `OrdersController#update`
  - Serializers: order
  - Model attributes: created_at, updated_at...
- `PATCH /api/orders/{id}/status` -> `OrdersController#status`
  - Serializers: order
  - Model attributes: created_at, updated_at...

#### PaymentsController (1 endpoints)
- `POST /api/payments/process` -> `PaymentsController#process_payment`
  - Serializers: payment
  - Model attributes: created_at, updated_at...

#### FloorsController (6 endpoints)
- `GET /api/floors` -> `FloorsController#index`
  - Serializers: floor
  - Model attributes: created_at, updated_at...
- `GET /api/floors/{id}` -> `FloorsController#show`
  - Serializers: floor
  - Model attributes: created_at, updated_at...
- `POST /api/floors` -> `FloorsController#create`
  - Serializers: floor
  - Model attributes: created_at, updated_at...
- `PUT /api/floors/{id}` -> `FloorsController#update`
  - Serializers: floor
  - Model attributes: created_at, updated_at...
- `PATCH /api/floors/{id}` -> `FloorsController#update`
  - Serializers: floor
  - Model attributes: created_at, updated_at...
- `DELETE /api/floors/{id}` -> `FloorsController#destroy`
  - Serializers: floor
  - Model attributes: created_at, updated_at...

#### TablesController (8 endpoints)
- `GET /api/tables` -> `TablesController#index` (✏️ MODIFIED)
  - Serializers: table
  - Model attributes: created_at, updated_at...
- `GET /api/tables/{id}` -> `TablesController#show` (✏️ MODIFIED)
  - Serializers: table
  - Model attributes: created_at, updated_at...
- `POST /api/tables` -> `TablesController#create`
  - Serializers: table
  - Model attributes: created_at, updated_at...
- `PUT /api/tables/{id}` -> `TablesController#update`
  - Serializers: table
  - Model attributes: created_at, updated_at...
- `PATCH /api/tables/{id}` -> `TablesController#update`
  - Serializers: table
  - Model attributes: created_at, updated_at...
- `DELETE /api/tables/{id}` -> `TablesController#destroy`
  - Serializers: table
  - Model attributes: created_at, updated_at...
- `POST /api/tables/{id}/start_order` -> `TablesController#start_order`
  - Serializers: table
  - Model attributes: created_at, updated_at...
- `PATCH /api/tables/{id}/clear` -> `TablesController#clear`
  - Serializers: table
  - Model attributes: created_at, updated_at...

#### StaffMembersController (7 endpoints)
- `GET /api/staff` -> `StaffMembersController#index` (✏️ MODIFIED)
  - Model attributes: created_at, updated_at...
- `GET /api/staff/{id}` -> `StaffMembersController#show` (✏️ MODIFIED)
  - Model attributes: created_at, updated_at...
- `POST /api/staff` -> `StaffMembersController#create`
  - Model attributes: created_at, updated_at...
- `PUT /api/staff/{id}` -> `StaffMembersController#update`
  - Model attributes: created_at, updated_at...
- `PATCH /api/staff/{id}` -> `StaffMembersController#update`
  - Model attributes: created_at, updated_at...
- `DELETE /api/staff/{id}` -> `StaffMembersController#destroy`
  - Model attributes: created_at, updated_at...
- `PATCH /api/staff/{id}/status` -> `StaffMembersController#status`
  - Model attributes: created_at, updated_at...

#### ReportsController (5 endpoints)
- `GET /api/reports` -> `ReportsController#index`
- `GET /api/reports/stats` -> `ReportsController#stats`
- `GET /api/reports/top-items` -> `ReportsController#top_items`
- `GET /api/reports/recent-orders` -> `ReportsController#recent_orders`
- `GET /api/reports/hourly-sales` -> `ReportsController#hourly_sales`
