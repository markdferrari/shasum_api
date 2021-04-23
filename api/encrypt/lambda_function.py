import json
import hashlib
import boto3

def lambda_handler(event, context):
    hash_function = hashlib.sha256()
    mystring = event['String']
    # Encode it next before hashing
    encoded_string = mystring.encode()
    # Hash it
    hash_function.update(encoded_string)
    # Get the output in clean format
    shasum = hash_function.hexdigest()
    # Set up dynamodb
    dynamodb = boto3.resource('dynamodb',region_name='eu-west-1')
    table = dynamodb.Table('main')
    response = table.put_item(
       Item={
            'String': event['String'],
            'Shasum': shasum
        }
    )
    return response