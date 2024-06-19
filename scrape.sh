#!/bin/bash

# Define the URL and query parameters
URL="https://community.tresata.com/posts.json"

# Define the API key and username
API_KEY="bb962f04bfc55701405c0ad38587f60e5784999be7d5fcced57d37d91a23651c"
API_USERNAME="system"
FIRST_POST_ID=2
OUTPUT_FILE="./documents/tresataSupportPosts"

# Execute the curl command and store the response
response=$(curl -s -X GET "$URL" -H "Api-Key: $API_KEY" -H "Api-Username: $API_USERNAME")

# Define the output file and add header
echo "username, topic_title, raw" > $OUTPUT_FILE

# Use jq to extract the last id from the latest_posts array
LAST_POST_ID=$(echo "$response" | jq '.latest_posts | last | .id')

CURR_POST_ID=$LAST_POST_ID

# Fetch posts in a loop until we reach the first post ID
while [ "$CURR_POST_ID" -gt "$FIRST_POST_ID" ]; do
  # Fetch the current batch of posts
  response=$(curl -s -X GET "$URL?before=$CURR_POST_ID" -H "Api-Key: $API_KEY" -H "Api-Username: $API_USERNAME")

  # Extract posts information using jq
  posts=$(echo "$response" | jq -r '.latest_posts[] | select(.username == "TresataSupport")| [ .topic_title, .raw] | @tsv' | sed 's/\t/|/g')

  # Append extracted information to the output file with a line break after each entry
  while IFS= read -r post; do
    echo "$posts" >> $OUTPUT_FILE
  done <<< "$posts"

  # Update CURR_POST_ID to the ID of the last post in the current batch
  CURR_POST_ID=$(echo "$response" | jq '.latest_posts | last | .id')
done


