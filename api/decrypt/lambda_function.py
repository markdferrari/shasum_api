import json
import boto3
from boto3.dynamodb.conditions import Key

def lambda_handler(event, context):
    shasum = event['Shasum']
    dynamodb = boto3.resource('dynamodb',region_name='eu-west-1')
    table = dynamodb.Table('main')
    # Filter based on shasum passed in via payload
    # Need a way to filter for any value of primary key, or else switch the primary/secondary
    response = table.query(
        KeyConditionExpression=
            Key('Shasum').eq(event['Shasum'])
    )
    return response['Items']