import os

from httplib2 import Credentials

def get_firebase_credentials():
    firebase_cred_path = os.getenv("FIREBASE_CREDENTIALS")
    if not firebase_cred_path:
        raise ValueError("Missing environment variable FIREBASE_CREDENTIALS")
    return Credentials.Certificate(firebase_cred_path)
