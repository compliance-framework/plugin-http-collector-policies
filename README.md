# HTTP Collector Policies for Compliance Framework HTTP Collector Plugin

OPA/Rego policies that validate HTTP response data collected by the [HTTP Collector Plugin](https://github.com/compliance-framework/plugin-http-collector).

## Available Policies

- **Success Status**: Ensures HTTP responses return 2xx status codes
- **Response Time**: Validates response times are under 5000ms  
- **JSON Content**: Requires responses have `application/json` content type

## Requirements

Install [opa](https://www.openpolicyagent.org/docs/latest/#running-opa) for testing & building the bundles.

## Commands

**Test policies:**
```shell
make test
```

**Validate syntax:**
```shell
make validate  
```

**Build bundle:**
```shell
make build
```

## How it Works

The HTTP Collector Plugin sends HTTP response data to these policies for validation. Each policy checks different aspects:

- Response status codes (success/failure)
- Response timing (performance)  
- Content types (API compliance)

Violations are reported to the compliance framework when checks fail.

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