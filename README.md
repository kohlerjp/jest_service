# JestService

JestService provides an API for encoding and decoding jokes in the JESt format.

## Up and running
The JestService server can be started locally through mix, or through docker containers.

### Starting with mix
To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate the database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

API is now available at [`localhost:4000/api/encode`](http://localhost:4000/api/encode)

### Starting with Docker
The project can also be run with Docker. The image is available on
[Docker Hub](https://hub.docker.com/repository/docker/johnpkohler/jest_service_phoenix).
The image can be pulled by running `docker pull johnpkohler/jest_service_phoenix:1.0`.
To start the web server and postgres database, run `docker-compose up` from the root
directory of the project. The web server will be available at http://localhost:4000.

## Usage
The JestService provides two endpoints, `/api/encode` and `/api/decode`.
To use the service, send a POST request to either endpoint with the appropriate parameters.

### Encode
Encoding a joke requires a POST to the `/api/encode` endpoint with a JSON object
containing a joke's body, punchline, and author. The response will contain the
encoded JESt message.

Example of JSON paramters: 
```JSON
{
  "body": "What do you call cheese that isn't yours",
  "punchline": "Nacho Cheese",
  "author": "Anita Bath"
}
```

An example curl request. The above JSON is available in the `encode_body.json` file.

```bash
curl -H "Content-Type: application/json" --data @encode_body.json http://localhost:4000/api/encode/
```

### Decode
Decoding a joke requires a POST to the `api/decode` endpoint with a JSON object
containing the JESt message. the response will contain the decoded JESt description.

Example of JSON paramters: 
```JSON
{"message": "What do you call cheese that isn't yours|4E6163686F20436865657365|Anita Bath"}
```

An example curl request. The above JSON is available in the `decode_body.json` file.

```bash
curl -H "Content-Type: application/json" --data @decode_body.json http://localhost:4000/api/encode/
```
