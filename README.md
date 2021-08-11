# BankGenServer

## Description
GenServer that models a bank account.

## Features
- Check that initial account balance is zero
- Add money to an account
- Remove money from an account

## How to interact with this project

`{:ok, pid} = Account.start_link` to start the GenServer

`Account.get_balance(pid)` to obtain the initial balance

`Account.deposit(pid, 10.0)` to add $10 to your account

`Account.withdraw(pid, 5)` to withdraw $5 from your account

## Installation

`mix deps.get` to get all the dependencies

`mix test` to test the project

`iex -S mix` to start the project

