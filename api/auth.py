import os
from fastapi import HTTPException, Depends
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from firebase_admin import auth

# Import a credential retrieval function from a separate file
from credentials import get_firebase_credentials  # Change the path if needed

# Initialize Firebase app securely
firebase_app = auth.initialize_app(get_firebase_credentials())  # Use imported function

# Create an instance of HTTPBearer
bearer = HTTPBearer()

# Function to validate JWT token
async def validate_token(creds: HTTPAuthorizationCredentials = Depends(bearer)):
    try:
        # Get the decoded token using Firebase's verification
        decoded_token = await auth.verify_id_token(creds.credentials)
        # Return the decoded token
        return decoded_token
    except auth.InvalidIdTokenError as e:
        # Raise an HTTPException with a more descriptive message
        raise HTTPException(status_code=401, detail="Invalid authentication token")
    except Exception as e:
        # Handle other potential errors
        raise HTTPException(status_code=500, detail="Internal server error")
