#!/bin/sh

while :
do
	IP_ADDRESS=`curl -s ifconfig.co`
	cat <<-EOF > /tmp/aws-route53-update.json
		{
			"Comment": "Update record to reflect new IP address of home router",
			"Changes": [{
				"Action": "UPSERT",
				"ResourceRecordSet": {
					"Name": "$ROUTE53_DOMAIN_A_RECORD.",
					"Type": "A",
					"TTL": 300,
					"ResourceRecords": [{
						"Value": "$IP_ADDRESS"
					}]
				}
			}]
		}
	EOF

	# aws route53 change-resource-record-sets --hosted-zone-id=$ROUTE53_ZONE_ID --change-batch file:///tmp/aws-route53-update.json

	echo "Updated $ROUTE53_DOMAIN_A_RECORD to $IP_ADDRESS"
	echo "Sleeping for $ROUTE53_UPDATE_FREQUENCY seconds..."
	sleep $ROUTE53_UPDATE_FREQUENCY
done
