package compliance_framework.http_collector.response_time_check

import data.compliance_framework.http_collector.response_time_check as policy

test_response_time_fast_request_ok if {
    inp := {
        "response_time_ms": 150,
        "status_code": 200,
        "success": true
    }
    v := count(policy.violation) with input as inp
    v == 0
}

test_response_time_moderate_request_ok if {
    inp := {
        "response_time_ms": 2500,
        "status_code": 200,
        "success": true
    }
    v := count(policy.violation) with input as inp
    v == 0
}

test_response_time_at_threshold_ok if {
    inp := {
        "response_time_ms": 5000,
        "status_code": 200,
        "success": true
    }
    v := count(policy.violation) with input as inp
    v == 0
}

test_response_time_exceeds_threshold_violation if {
    inp := {
        "response_time_ms": 6000,
        "status_code": 200,
        "success": true
    }
    v := count(policy.violation) with input as inp
    v == 1
}

test_response_time_very_slow_violation if {
    inp := {
        "response_time_ms": 15000,
        "status_code": 500,
        "success": false,
        "error": "Database timeout"
    }
    v := count(policy.violation) with input as inp
    v == 1
}

test_response_time_missing_field_no_violation if {
    inp := {
        "status_code": 200,
        "success": true
    }
    v := count(policy.violation) with input as inp
    v == 0
}