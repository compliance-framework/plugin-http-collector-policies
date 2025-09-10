# HTTP Collector Policies for use in Compliance Framework HTTP Collector Plugin

## Requirements

Install [opa](https://www.openpolicyagent.org/docs/latest/#running-opa) for testing & building the bundles.

## Testing

```shell
make test
```

## Bundling

Policies are built into bundle to make distribution easier. 

You can easily build the policies by running 
```shell
make build
```

## Running policies locally

```shell
opa eval -I -b policies -f pretty data.compliance_framework <<EOF 
{
  "status_code": 200,
  "status": "200 OK",
  "headers": {
    "Content-Type": ["application/json"]
  },
  "body": "Sample response body",
  "response_time_ms": 150,
  "success": true
}
EOF
```

## Writing policies

Policies are written in the [Rego](https://www.openpolicyagent.org/docs/latest/policy-language/) language.

```rego
package compliance_framework.http_collector.ensure_success_status

import future.keywords.in

violation[{}] {
	input.success == false
}

title := "HTTP endpoint should return successful status codes"
description := "HTTP endpoints should return 2xx status codes to ensure proper service functionality"
labels := {
    "severity": "high"
}
```