#!/bin/sh
CURRENT_IP_ADDRESS=''

echo "Checking for updates every $ROUTE53_UPDATE_FREQUENCY seconds"

while :
do
	IP_ADDRESS=`curl -s api.ipify.org`

	if [ "$IP_ADDRESS" == "$CURRENT_IP_ADDRESS" ]; then
		printf "."
		sleep $ROUTE53_UPDATE_FREQUENCY
		continue
	else
		echo "Updated $ROUTE53_DOMAIN_A_RECORD to $IP_ADDRESS"
		CURRENT_IP_ADDRESS=$IP_ADDRESS
	fi

	cat <<-EOF > /tmp/aws-route53-update.json
		{
			"Comment": "Update record to reflect new home IP address",
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

	aws route53 change-resource-record-sets \
		--hosted-zone-id=$ROUTE53_ZONE_ID \
		--change-batch file:///tmp/aws-route53-update.json
done
