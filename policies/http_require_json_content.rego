package compliance_framework.http_collector.require_json_content

import future.keywords.in

violation[{}] {
	not input.headers["Content-Type"]
}

violation[{}] {
	input.headers["Content-Type"]
	count([ct | ct := input.headers["Content-Type"][_]; contains(ct, "application/json")]) == 0
}

title := "HTTP endpoint should return JSON content type"
description := "API endpoints should return JSON content type for proper client compatibility"
labels := {
    "severity": "low"
}