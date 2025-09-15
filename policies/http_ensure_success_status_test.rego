package compliance_framework.http_collector.ensure_success_status

import data.compliance_framework.http_collector.ensure_success_status as policy

test_success_status_200_ok if {
    inp := {
        "status_code": 200,
        "success": true,
        "response_time_ms": 150
    }
    v := count(policy.violation) with input as inp
    v == 0
}

test_success_status_201_created_ok if {
    inp := {
        "status_code": 201,
        "success": true,
        "response_time_ms": 200
    }
    v := count(policy.violation) with input as inp
    v == 0
}

test_success_status_fails_for_500_error if {
    inp := {
        "status_code": 500,
        "success": false,
        "error": "Internal server error",
        "response_time_ms": 100
    }
    v := count(policy.violation) with input as inp
    v == 1
}

test_success_status_fails_for_404_client_error if {
    inp := {
        "status_code": 404,
        "success": false,
        "error": "Not found",
        "response_time_ms": 50
    }
    v := count(policy.violation) with input as inp
    v == 1
}

test_success_status_fails_for_missing_success_field if {
    inp := {
        "status_code": 200,
        "response_time_ms": 150
    }
    v := count(policy.violation) with input as inp
    v == 1
}

test_success_status_fails_for_success_false_despite_200 if {
    inp := {
        "status_code": 200,
        "success": false,
        "error": "Application error",
        "response_time_ms": 300
    }
    v := count(policy.violation) with input as inp
    v == 1
}