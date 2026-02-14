# API Documentation Summary

Generated: 2026-02-d 11:48:29

## Statistics
- Total Models: 3
- Total Controllers: 3
- Total Serializers: 0
- Total Helpers: 0
- Total Routes: 11
- Total Endpoints: 11
- New Endpoints: 1
- Modified Endpoints: 1

## File Paths

### Controllers:
- `application`: `app/controllers/application_controller.rb`
- `contacts`: `app/controllers/api/contacts_controller.rb`
- `auth`: `app/controllers/api/auth_controller.rb`

### Models:
- `contact`: `{'path': 'app/models/contact.rb', 'attributes': {'created_at': {'type': 'string', 'format': 'date-time', 'description': 'Creation timestamp'}, 'updated_at': {'type': 'string', 'format': 'date-time', 'description': 'Update timestamp'}}}`
- `jwt_denylist`: `{'path': 'app/models/jwt_denylist.rb', 'attributes': {'created_at': {'type': 'string', 'format': 'date-time', 'description': 'Creation timestamp'}, 'updated_at': {'type': 'string', 'format': 'date-time', 'description': 'Update timestamp'}}}`
- `user`: `{'path': 'app/models/user.rb', 'attributes': {'created_at': {'type': 'string', 'format': 'date-time', 'description': 'Creation timestamp'}, 'updated_at': {'type': 'string', 'format': 'date-time', 'description': 'Update timestamp'}}}`

### Serializers:

### Helpers:

### Model Attributes Summary:

#### contact
- `created_at`: string
- `updated_at`: string

#### jwt_denylist
- `created_at`: string
- `updated_at`: string

#### user
- `created_at`: string
- `updated_at`: string

### Endpoints by Controller:

#### ContactsController (2 endpoints)
- `GET /api/contacts` -> `ContactsController#index` (🆕 NEW)
  - Model attributes: created_at, updated_at...
- `POST /api/contacts` -> `ContactsController#create`
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
