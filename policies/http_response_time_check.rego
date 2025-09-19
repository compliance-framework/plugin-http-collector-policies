package compliance_framework.http_collector.response_time_check

violation[{}] if {
	input.response_time_ms > 5000
}

title := "HTTP response time exceeds acceptable limits"
description := "HTTP endpoints should respond within reasonable time limits to ensure good user experience"
remarks := "Optimize the service performance or increase timeout limits"
labels := {
    "severity": "medium"
}