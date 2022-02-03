# cherry-pdf

##### [![Rubocop](https://github.com/faraquet/cherry-pdf/actions/workflows/rubocop.yml/badge.svg)](https://github.com/faraquet/cherry-pdf/actions)

---

### Ruby on Rails pdf generator based on headless Chrome



### Usage

Copy `.env.sample` to `.env`.

Copy `config/database.yml.sample` to `config/database.yml`.

```
docker-compose up -d
```

```console
curl --location --request POST 'localhost:3003/html_to_pdf' \
--header 'Content-type: application/json' \
--data-raw '{"content": "<h1> Awesome! </h1>", "scale": 0.5, "landscape": true}'
```
### Authentication

By default authentication disabled.

To enable it please use `TOKEN_AUTHENTICATABLE=true` in your `.env` file.

**Create a new user**:

To enable self-registration via API please make sure that you `SELF_REGISTRATION_AVAILABLE` is set to `true` in your `.env` file.

```console
curl -X POST -H 'Content-type: application/json' -d '{"email": "cherry-pdf@example.com", "password": "testpassword"}' localhost:3003/register
```

**Authenticate a user**:

```console
curl -X POST -H 'Content-type: application/json' -d '{"email": "cherry-pdf@example.com", "password": "testpassword"}' localhost:3003/login
```

On successful login, `{"auth_token": <token>, "expires_at": <datetime>}` will be returned. By default this token will be expired after 24 hours.

After that you have to add `Authorization` header to your request:

```
curl --location --request POST 'localhost:3003/html_to_pdf' \
--header 'Content-type: application/json' \
--header 'Authorization: <token>' \
--data-raw '{"content": "<h1> Awesome! </h1>", "scale": 0.5, "landscape": true}'
```

### Todo

- Readme
- More options to pdf-generation
- Specs
