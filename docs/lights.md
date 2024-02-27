# Smart Home Lights

This repo contains endpoints for getting the current status of the lights in your network, adding new lights, and changing the status of lights in the network.

## Endpoints

### GET /api/lights

Should respond with 200 status & response body.

Example Response -

```json
"lights": [{ "id": 1, "location": "Kitchen", "status": false }]
```

### POST /api/lights

Example Request - 

```json
{ "location": "Living Room" }
```

Should respond with 201 status & response body.

Example Response -

```json
"light": { "id": 2, "location": "Living Room", "status": false }
```
 
### POST /api/lights/switch

Example Request - 

```json
{ "id": 0 }
```
Should respond with 202 status & response body.

Example Response -

```json
"light": {
      "id": 0,
      "location": "Living Room",
      "status": true,
    }
```
