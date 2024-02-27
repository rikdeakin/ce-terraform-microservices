# Smart Home Status Service

This service will contact the other services and provide a centralised status of all of the services. This service cannot change the properties of the other services, it is meant only to be a way to poll all the other services in a single location.

This service requires a `.env.local` file at the root directory to discover the other services. The `.env.example` provides an example of the variables needed.

Current services available;

- [Lighting](https://github.com/northcoders/ce-smart-home-lights)
- [Heating](https://github.com/northcoders/ce-smart-home-heating)

## Endpoints

### GET /api/status/health

This should reply with a 200 and no content

### GET /api/status

Example Response

```json
{
  "lighting": {
    "status": true,
    "lights": [{ "id": 1, "location": "Kitchen", "status": false }]
  },
  "heating": { "status": true, "temperature": 21 },
  "auth": {
    "status": true,
    "info": { "loggedIn": true, "username": "emilyisc00l" }
  }
}
```

If any of the service are unable to be contact for whatever reason, the status will be `false` and no other information will be given.

Example Response

```json
{
  "lighting": {
    "status": false
  },
  "heating": { "status": true, "temperature": 21 },
  "auth": { "status": false }
}
```

### POST /api/status/register

This endpoint should reply with a 201 status code and success message

Example Request

```json
{
  "username": "emilyisc00l",
  "password": "emilysgoodpassword!"
}
```

Example Response

```json
{
  "msg": "Registration Successful"
}
```

### POST /api/auth/login

This endpoint will reply with a 200 and a success message if the user exists in the credentials object and the password is correct for that user. The username will then be stored in memory on the API until logged out or restarted.

Example Request

```json
{
  "username": "emilyisc00l",
  "password": "emilysgoodpassword!"
}
```

Example Response

```json
{
  "msg": "Authorisation successful"
}
```

### POST /api/auth/logout

This endpoint will reply with a 200 and a success message. The user information will then be cleared from memory.

Example Response

```json
{
  "msg": "Logged out successfully"
}
```
