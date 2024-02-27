# Smart Home Heating

This repo contains endpoints for getting the current status of the heating in your house and changing the desired temperature.

## GET /api/heating

Should respond with 200 status & response body.

Example Response -

```json
{ "temperature": 21 }
```

## POST /api/heating

Example Request -
```json
{ "temperature": 35 }
```
Should respond with 201 status & response body.

Example Response -

```json
{ "temperature": 35 }
```

## GET /api/heating/healthcheck

Should respond with 200 status & response body.

Example Response -

```json
{ "health": "OK" }
```
