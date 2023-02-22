# Salesforce DML via URL

This package allows org-external stakeholders to perform specific DML operations by following URL unique to their records

## Why

In orgs managing vast numbers of stakeholders, keeping records up to date can be cumbersome. For repetitive tasks, allowing stakeholders to perform certain DML operations themselves can significantly cut down on manual labor and improve data quality. Examples of such tasks include:

- Confirming email addresses
- Tracking meeting attendance
- Progressing to the next stage of an engagement journey

Generally, however, all DML operations that are the result of a Yes/No question may qualify.

## How

Stakeholders are sent URLs to a force.com site containing parameters relating to their records (e.g. Contact ID). When visited, the site is configured to call a method on an Apex class set to do the following:

- Read in the URL parameters (e.g. Contact ID)
- Take specific actions based on their content (e.g. opt into newsletter sign up)
- Redirect the user to another page

## Setup

To use this package you will need to

- set up a force.com site in your org and set [click.page](/force-app/main/default/pages/click.page) as the 'Active Site Home Page'
- configure possible 'paths' inside the [Click Handler](/force-app/main/default/classes/ClickHandler.cls) class performing the desired operations and returning the desired PageReference
- Optional: Use [result.page](/force-app/main/default/pages/result.page) as a confirmation page; you will need to also allow it in your Site settings.

## Caution

Enabling DML operations via URLs should be done carefully as to ensure data integrity and privacy. Test carefully.
