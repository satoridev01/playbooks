LIMIT=200
curl -s -b "wordpress_logged_in_fe5d88f1bcbcc8a110e30eefc934199e=fearcito%7C1655637841%7C3rCC7SRzmNGQu8r83KEOzGpvB2eZICy0AKivRtYjMJH%7C0f484c1edb3e84ab78056e7d40bc4a9c5267a372d24a3a31c09cf9fd158cb63d" "https://www.satori-ci.com/api/reports?limit=$LIMIT"| gunzip | jq '.rows[]'
