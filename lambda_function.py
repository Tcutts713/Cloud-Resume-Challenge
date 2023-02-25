import json
import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('Visits')

def lambda_handler(event, context):
    response = table.get_item(Key={
       'Count':'0'
    })
    
    counter = response['Item']['counter']
    counter = counter + 1
    
    response = table.put_item(Item={
        'Count' : '0',
        'counter': counter
    })
    
  
    return{
        'statusCode': 200,
        'headers': {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
        },
      "body": counter
    }