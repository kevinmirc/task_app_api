## Task App Api Documentation

-----------------

###Getting Started
URI: `http://localhost:3000/api/v1`

Other than creating a user or creating a session, every request sent this api must be authenticated using a token in the header. You can recieve your Auth-Token by either creating a user or creating a session.

Creating a user:
```
params = {
  form: 
  {
    email: 'mynamejeff@gmail.com',
    password: 'password123',
    password_confirmation: 'password123'
  }
}

request.post('http://localhost:3000/api/v1/users', payload, (err, res, body) => {
  if (err) { throw err };
  console.log(res.statusCode);
  console.log(body);
});
```
response:
```
201
{
  "user":
  {
    "id":3,
    "email":"mynamejeff@gmail.com",
    "created_at":"2016-06-28T18:26:01.956Z",
    "updated_at":"2016-06-28T18:26:01.956Z",
    "authentication_token":"BQ3O1QqjtuGNTiDWnXqv"
  }
}
```
To get the `Auth-Token` of an existing user you can POST to /session:
```
params = {
  form: 
  {
    email: 'mynamejeff@gmail.com',
    password: 'password123'
  }
}

request.post(uri + 'sessions', params, (err, res, body) => {
  if (err) { throw err };
  console.log(res.statusCode);
  console.log(body);
});
```
response:
```
200
{
  "user":{
    "id":3,
    "email":"mynamejeff@gmail.com",
    "created_at":"2016-06-28T18:26:01.956Z",
    "updated_at":"2016-06-28T18:26:01.956Z",
    "authentication_token":"BQ3O1QqjtuGNTiDWnXqv"
  }
}
```
For all other requests to the api, use `"Auth-Token":user_authentication_token` in the header. Example:
```
params = {
  headers: {
    'Auth-Token': 'BQ3O1QqjtuGNTiDWnXqv'
  }
}

request.get(uri + 'users', params, (err, res, body) => {
  if (err) { throw err };
  console.log(res.statusCode);
  console.log(body)
});
```
response:
```
200
{
  "users": [
    {
      "id":1,
      "email":"kmircovich1@gmail.com",
      "task_ids":[]
    },
    {
      "id":2,
      "email":"mirc89@yahoo.com",
      "task_ids":[]
    },
    {
      "id":3,
      "email":"mynamejeff@gmail.com",
      "task_ids":[]
    }
  ]
}
```

###Sessions
`GET /sessions` will return the user and their Auth-Token:
```
params = {
  form: 
  {
    email: 'mynamejeff@gmail.com',
    password: 'password123'
  }
}

request.post(uri + 'sessions', params, (err, res, body) => {
  if (err) { throw err };
  console.log(res.statusCode);
  console.log(body)
});
```

`POST /sessions/facebook` will find or create a user based on a facebook token, and return that user with their access_token
```
params = {
  form: 
  {
    facebook_token: 'your_facebook_token'
  }
}

request.post(uri + 'sessions/facebook', params, (err, res, body) => {
  if (err) { throw err };
  console.log(res.statusCode);
  console.log(body)
});

```

###Users

`GET /users` to return all users
```
params = {
  headers: {
    'Auth-Token': 'BQ3O1QqjtuGNTiDWnXqv'
  }
}

request.get(uri + 'users', params, (err, res, body) => {
  if (err) { throw err };
  console.log(res.statusCode);
  console.log(body)
});
```

`GET /users/:id` to return specific user
```
params = {
  headers:
  {
    'Auth-Token': 'BQ3O1QqjtuGNTiDWnXqv'
  }
}

request.get(uri + 'users/3', params, (err, res, body) => {
  if (err) { throw err };
  console.log(res.statusCode);
  console.log(body)
});
```

`POST /users` to create a user:
```
params = {
  form: 
  {
    email: 'mynamejeff@gmail.com',
    password: 'password123',
    password_confirmation: 'password123'
  }
}

request.post('http://localhost:3000/api/v1/users', payload, (err, res, body) => {
  if (err) { throw err };
  console.log(res.statusCode);
  console.log(body);
});
```

`GET /users/find` allows tou to find a user by their email:
```
params = {
  headers:
  {
    'Auth-Token': 'BQ3O1QqjtuGNTiDWnXqv'
  }
}

request.get(uri + 'users/3', params, (err, res, body) => {
  if (err) { throw err };
  console.log(res.statusCode);
  console.log(body);
});
```

###Tasks

`GET /tasks` returns all the task:
```
params = {
  headers:
  {
    'Auth-Token': 'BQ3O1QqjtuGNTiDWnXqv'
  }
}

request.get(uri + '/tasks', params, (err, res, body) => {
  if (err) { throw err };
  console.log(res.statusCode);
  console.log(body);
});
```

`GET /tasks/:id` returns the task with that id:
```
params = {
  headers:
  {
    'Auth-Token': 'BQ3O1QqjtuGNTiDWnXqv'
  }
}

request.get(uri + '/tasks/1', params, (err, res, body) => {
  if (err) { throw err };
  console.log(res.statusCode);
  console.log(body);
});
```

`POST '/tasks'` creates a task:
```
params = {
  headers:
  {
    'Auth-Token': 'BQ3O1QqjtuGNTiDWnXqv'
  },
  form: {
    title: "Write some documentation",
    description: "Add is to the readme and include lot's of examples."
  }
}

request.post(uri + '/tasks', params, (err, res, body) => {
  if (err) { throw err };
  console.log(res.statusCode);
  console.log(body);
});
```

`PUT /tasks/:id` updates the attributes of a task:
```
params = {
  headers:
  {
    'Auth-Token': 'BQ3O1QqjtuGNTiDWnXqv'
  },
  form: {
    title: "Write some documentation",
    description: "Make it super front end heavy and be able to switch languages of examples."
  }
}

request.put(uri + '/tasks/1', params, (err, res, body) => {
  if (err) { throw err };
  console.log(res.statusCode);
  console.log(body);
});
```

`DELETE /tasks/:id` to delete a task:
```
params = {
  headers:
  {
    'Auth-Token': 'BQ3O1QqjtuGNTiDWnXqv'
  }
}

request.delete(uri + 'tasks/2', params, (err, res, body) => {
  if (err) { throw err };
  console.log(res.statusCode);
  console.log(body);
});
```

###Assignments

`GET /assignments` returns all the assignments:
```
params = {
  headers:
  {
    'Auth-Token': 'BQ3O1QqjtuGNTiDWnXqv'
  }
}

request.get(uri + 'assignments', params, (err, res, body) => {
  if (err) { throw err };
  console.log(res.statusCode);
  console.log(body);
});
```

`GET /assignments/:id` returns the assignment with that id:
```
params = {
  headers:
  {
    'Auth-Token': 'BQ3O1QqjtuGNTiDWnXqv'
  }
}

request.get(uri + 'assignments/1', params, (err, res, body) => {
  if (err) { throw err };
  console.log(res.statusCode);
  console.log(body);
});
```

`POST /assignments` creates an assignments:
```
params = {
  headers:
  {
    'Auth-Token': 'BQ3O1QqjtuGNTiDWnXqv'
  },
  form: {
    user_id: '3',
    task_id: '1'
  }
}

request.post(uri + 'assignments', params, (err, res, body) => {
  if (err) { throw err };
  console.log(res.statusCode);
  console.log(body);
});
```

`DELETE /assignments/:id` deletes the assignment with that ID:
```
params = {
  headers:
  {
    'Auth-Token': 'BQ3O1QqjtuGNTiDWnXqv'
  }
}

request.delete(uri + 'assignments/1', params, (err, res, body) => {
  if (err) { throw err };
  console.log(res.statusCode);
  console.log(body);
});
```
