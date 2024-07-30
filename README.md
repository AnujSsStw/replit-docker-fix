# Rails Security Logging Demo

This application demonstrates security logging in a Ruby on Rails application. It includes basic user authentication features (signup and login) and showcases how to implement structured logging for security events.

## Features

- User registration and authentication
- Dashboard displaying recent security logs
- Structured logging of security events
- Dockerized application for easy deployment

## Prerequisites

- Docker

## Getting Started

1. Clone the repository:
   ```
   git clone https://github.com/your-username/rails_security_logging_demo.git
   cd rails_security_logging_demo
   ```

2. Build the Docker image:
   ```
   docker build -t rails_security_logging_demo .
   ```

3. Run the container:
   ```
   docker run -p 8880:8880 rails_security_logging_demo
   ```

4. Access the application at `http://localhost:8880`

## Using the Application

1. **Sign Up**: Navigate to the signup page and create a new account.
2. **Log In**: Use your credentials to log in to the application.
3. **Dashboard**: Once logged in, you'll be redirected to the dashboard where you can view recent security logs.
4. **Log Out**: Use the logout link in the header to end your session.

## Security Logging Implementation

This application implements security logging using the following techniques:

1. **Custom SecurityLogger Class**: 
   - Located in `config/initializers/security_logger.rb`
   - Implements the Singleton pattern to ensure a single instance of the logger
   - Stores logs in memory (for demonstration purposes)
   - Provides methods for logging events and retrieving recent logs

2. **Structured Log Format**:
   - Each log entry includes:
     - Timestamp
     - Event Type
     - Message
     - User ID (if applicable)
     - IP Address
     - Additional Details

3. **Logged Security Events**:
   - User registration (successful and failed attempts)
   - User authentication (successful and failed login attempts)
   - Unauthorized access attempts

4. **Integration with Rails Logger**:
   - Security events are also logged using `Rails.logger` for persistence

5. **Controller-level Logging**:
   - Security events are logged in relevant controller actions (e.g., UsersController, SessionsController)

6. **IP Address Logging**:
   - Client IP addresses are logged for each security event using `request.remote_ip`

7. **Dashboard Display**:
   - Recent security logs are displayed on the user dashboard for easy monitoring

## Security Considerations

- This demo uses in-memory storage for logs, which is not suitable for production. In a real-world scenario, you would use a persistent storage solution.
- Sensitive information (like passwords) is never logged.
- IP addresses are logged, but in a production environment, you should consider data privacy regulations.

## Extending the Demo

To enhance this demo for production use, consider:

1. Implementing a persistent storage solution for logs (e.g., database, external logging service)
2. Adding more granular logging for other security-relevant events
3. Implementing log rotation and archiving
4. Adding analytics and alerting based on log patterns
5. Enhancing the dashboard with filtering and search capabilities