#!/bin/bash


# Define the URL and query parameters
URL="https://community.tresata.com/posts.json"

# Define the API key and username
API_KEY="bb962f04bfc55701405c0ad38587f60e5784999be7d5fcced57d37d91a23651c"
API_USERNAME="system"
FIRST_POST_ID=2
OUTPUT_FILE="./extracted-posts.txt"

# Execute the curl command and store the response
response=$(curl -s -X GET "$URL" -H "Api-Key: $API_KEY" -H "Api-Username: $API_USERNAME")

# Use jq to extract the last id from the latest_posts array
LAST_POST_ID=$(echo "$response" | jq '.latest_posts | last | .id')


CURR_POST_ID=$LAST_POST_ID

while [ $CURR_POST_ID -gt $FIRST_POST_ID ]; do
  curl -X GET "$URL?before=$CURR_POST_ID" -H "Api-Key: $API_KEY" -H "Api-Username: $API_USERNAME"| jq '.latest_posts[]| .raw' >> $OUTPUT_FILE
  CURR_POST_ID=$(curl -s -X GET "$URL?before=$CURR_POST_ID" -H "Api-Key: $API_KEY" -H "Api-Username: $API_USERNAME"| jq '.latest_posts | last | .id')
done
