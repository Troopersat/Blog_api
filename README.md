# Blog API

This Blog API is built with Ruby on Rails, providing endpoints for user authentication, CRUD operations for blog posts, and a like feature.

## API Endpoints

### Authentication
- **POST /signup** - Register a new user with `name`, `username`, `email`, and `password`.
- **POST /login** - Log in a user with `email` and `password`, returning a JWT token.

### Blog Posts
- **POST /posts** - Create a new blog post. Requires authentication. Accepts `title` and `content`.
- **GET /posts** - Retrieve all blog posts. Supports pagination with `page` query parameter.
- **GET /posts/:id** - Retrieve a specific blog post by its `id`.
- **PATCH /posts/:id** - Update a blog post. Requires authentication and ownership.
- **DELETE /posts/:id** - Delete a blog post. Requires authentication and ownership.

### Likes
- **POST /posts/:id/like** - Like a specific blog post. Requires authentication. Increments the `likes_count` for the post by 1.
- **GET /posts/:id/likes_count** - Retrieve the `likes_count` for a specific post.

## Running the API Locally

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/Troopersat/Blog_api.git
   cd Blog_api
