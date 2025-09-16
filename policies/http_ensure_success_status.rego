package compliance_framework.http_collector.ensure_success_status

violation[{"title": "HTTP endpoint returned non-success status code", "description": "HTTP endpoints should return 2xx status codes to ensure proper service functionality", "remarks": "Check the endpoint configuration and ensure the service is running properly"}] if {
	not input.success
}

title := "HTTP endpoint should return successful status codes"
description := "HTTP endpoints should return 2xx status codes to ensure proper service functionality"
labels := {
    "severity": "high"
}