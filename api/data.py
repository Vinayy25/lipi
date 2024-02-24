from fastapi import Depends, HTTPException
from redis import Redis
from datetime import timedelta, datetime
from auth import validate_token

# Configure Redis connection (replace with your values)
redis_host = "localhost"
redis_port = 6379
redis_db = 0

# Create a Redis client connection
redis_client = Redis(host=redis_host, port=redis_port, db=redis_db)

# Function to check if a JWT is in the cache and valid
async def check_cached_jwt(jwt: str):
    cached_jwt = redis_client.get(f"jwt_{jwt}")
    if cached_jwt and cached_jwt.decode() == jwt:
        # Check expiration time
        if datetime.now() < redis_client.hgetall(f"jwt_info_{jwt}").get(b"expiry", None).decode() > datetime.now():
            return True
    return False

# Function to add a verified JWT to the cache
async def cache_verified_jwt(jwt: str, decoded_token):
    # Set expiry time 10 minutes from now
    expiry = datetime.now() + timedelta(minutes=10)
    # Store JWT and expiry in separate keys for better management
    redis_client.set(f"jwt_{jwt}", jwt)
    redis_client.hmset(f"jwt_info_{jwt}", {"expiry": expiry.isoformat()})

# Function to handle JWT verification and caching
async def handle_jwt(jwt: str):
    # Check cache first
    if await check_cached_jwt(jwt):
        return True
    # Validate the JWT if not cached
    decoded_token = await validate_token(jwt)
    # Cache the verified JWT
    await cache_verified_jwt(jwt, decoded_token)
    return True

# Dependency function to check JWT and perform caching (usage example)
async def get_current_user(jwt: str = Depends(handle_jwt)):
    # JWT is already verified and cached, use the decoded data here (if needed)
    # ...
    return True

# # Example usage in a FastAPI route
# @app.post("/protected_endpoint")
# async def protected_endpoint():
#     # Use the get_current_user dependency to ensure JWT validation and caching
#     await get_current_user()
#     # Your protected endpoint logic here
#     return {"message": "This is a protected endpoint!"}
