== Sample Friends App

This is a sample friend messaging app created to play around with some
query messages.

Here is the class model used in this sample application:

![class diagram](https://raw.github.com/jimweirich/sample_friends_app/master/doc/models.png "Class Diagram")

The key is to get a list of messages intended for a particular user,
but only if the sender is listed as a friend of the user in question.
Messages from non-friends will be ignored.

The query is implemented 3 different ways in the User module:

* incoming_messages -- Uses two queries, one to get the list of
  friends, the other to get the messages from those friends.

* incoming_messages_by_sql -- A straight SQL query that does
  everything in a single query.

* incoming_messages_by_ar -- Same as the _by_sql version, but uses the
  natural rails query mechanisms.
