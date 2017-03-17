DynDNS for AWS Route53
============================

## Usage
```
ROUTE53_DOMAIN_A_RECORD=home.example.com \
ROUTE53_ZONE_ID=A0A10Z91AMR \
ROUTE53_UPDATE_FREQUENCY=3600 \
AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE \
AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY \
AWS_DEFAULT_REGION=us-west-2 \
./run.sh
```

Docker
```
docker run \
  -d \
  --name="dyndns" \
  -e "AWS_ACCESS_KEY_ID"="AKIAIOSFODNN7EXAMPLE" \
  -e "AWS_SECRET_ACCESS_KEY"="wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY" \
  -e "AWS_DEFAULT_REGION"="us-west-2" \
  -e "ROUTE53_DOMAIN_A_RECORD"="home.example.com" \
  -e "ROUTE53_UPDATE_FREQUENCY"="3600" \
  -e "ROUTE53_ZONE_ID"="Z2T40ZE2912MR" \
  tylersmalley/route53-dyndns
```
