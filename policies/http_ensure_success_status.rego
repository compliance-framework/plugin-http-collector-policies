package compliance_framework.http_collector.ensure_success_status

violation[{}] if {
	not input.success
}

title := "HTTP endpoint returned non-success status code"
description := "HTTP endpoints should return 2xx status codes to ensure proper service functionality"
remarks := "Check the endpoint configuration and ensure the service is running properly"
labels := {
    "severity": "high"
}