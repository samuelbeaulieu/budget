# Budget

Income, Expense & Transfer Tracker + Budgeting app for iOS made with SwiftUI.

## Roadmap

This is a work in progress. I'm working on the following features:

### Phase 1 - The basics

- View a list of transaction
  - The item row should include:
    - Icon for the selected category, with a coloured background
    - The name of the transaction, for example: Apple One
    - The account used for the transaction, for example: Credit Card
    - The amount of the transaction
  - Should be separated by dates
  - Should be ordered from the most recent
  - Should be able to delete a transaction with a swipe gesture and with an edit button at the top to toggle the list edit mode
- Add a new transaction
  - Set the transaction type
    - Income
    - Expense
    - Transfer
  - Set the amount of the transaction
  - Set the name of the transaction(payee/payer), for example: Apple One
  - Set the category of the transaction, for exemple: Health
    - Would be nice to have a subcategory selection, for exemple: Dental
  - Set the account used for the transaction, for example: Credit Card
  - Set the date of the transaction. By default at the current date.
  - Set an optional note
- Manage Categories
  - Should be able to add, edit & remove a category
  - A category should consist of:
    - A name
    - A color
    - An icon
- Manage Accounts
  - Should be able to add, edit & remove an account
  - An account should consist of:
    - A name
    - A description
    - A type
- Notifications reminding the user to log transactions
- Export data to .csv

### Phase 2 - Recurring Transactions

- View a list of recurring transactions
- Add recurring transactions
  - Choose a recurrence:
    - Never
    - Daily
    - Weekly
    - Every 2 weeks
    - Every 3 weeks
    - Every 4 weeks
    - Monthly
    - Every 2 months
    - Every 3 months
    - Every 4 months
    - Every 5 months
    - Every 6 months
    - Yearly
  - Choose a reminder:
    - None
    - Same day
    - 1 day before
    - 2 days before
- Notifications based on the selected reminder for recurring transactions

### Phase 3 - Full support for importing & exporting data

Basic export to .csv should be possible in phase 1.

More details to come...

### Phase 4 - Budgeting

Setting a budget with a weekly or monthly limit.

More details to come...

### Phase 5 - Insights & Trends

Graphs to show the amount spent per category, per month, per year, etc.

More details to come...

### Phase 6 - Advanced Filtering & Search

Filter transactions by:

- Date
- Category
- Account
- Amount
- Transaction type
- Recurrence

Search transactions by:

- Name
- Payee
- Payer
- Description

More details to come...

### Phase 7 - Internationalizing

All text in the app should be localized in english from the start.

More details to come...

### Phase 8 - Full support for iPad & Mac

SwiftUI should make it usable on both iPad and Mac before this phase. If there are problems with the design, it should be easy to fix in this phase.

More details to come...

### Phase 9 - Themes

The app should be able to switch between light and dark mode automatically from the start. Manually switching between light and dark mode, color themes and other visual customization options will be done here.

More details to come...

### Phase 10 - Add Photos & Documents to the transaction

I see it a lot in other apps, not sure if it's really necessary.

More details to come...
