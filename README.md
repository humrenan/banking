# BankingApi

A banking Api which is possible create accounts for users and make basic banking operations: `:deposit`, `:withdraw` and `:transaction`  

 
# setup

To run this project you need first to have a Postgres container running on port 5432. We embed a docker-compose configuration to ease setting up the environment.  

```sh
# Run this to have a database on 5432
    docker-compose up -d

```

Start the project: 

```sh
# On the root folder:
    mix setup
```

---
## API

All APIs requests are under `/api` scope.



## Create user
Creates an User + Account

### Request
`POST /users/create`

```json
// Example
{
	"name": "Jimi Hendrix",
	"email": "jimihendrix@email.com",
	"password": "Kb0ySi1C",
}
```

---
## Deposit
Deposits to an existing account.


### Request
  `POST /accounts/:id/deposit/`


```json
// Body
{
  "value": "10"
}
```
---
## Withdraw
Withdraws to an existing account.


### Request
  `POST /accounts/:id/withdraw/` 


```json
// Body
{
  "value": "10"
}
```

---
## Transaction
Transaction between existing accounts.


### Request
  `POST /accounts/transaction/` 


```json
// Body
{
	"from_id": "3ab097dd-2d7a-4c16-808c-7b3948d4c209",
	"to_id": "aee21185-bc3f-4684-98c4-fda505adb0e5",
	"value": "10"
}
```
---

## List Users
List all users

### Request

`GET /users/list`


```json
// Body
{
  
}
```
