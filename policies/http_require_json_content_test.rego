package compliance_framework.http_collector.require_json_content

import data.compliance_framework.http_collector.require_json_content as policy

test_json_content_type_plain_ok {
    inp := {
        "headers": {
            "Content-Type": ["application/json"],
            "Server": ["nginx"]
        },
        "status_code": 200,
        "success": true
    }
    v := count(policy.violation) with input as inp
    v == 0
}

test_json_content_type_with_charset_ok {
    inp := {
        "headers": {
            "Content-Type": ["application/json; charset=utf-8"],
            "Content-Length": ["1234"]
        },
        "status_code": 200,
        "success": true
    }
    v := count(policy.violation) with input as inp
    v == 0
}

test_json_content_type_with_boundary_ok {
    inp := {
        "headers": {
            "Content-Type": ["application/json; boundary=something"]
        },
        "status_code": 200,
        "success": true
    }
    v := count(policy.violation) with input as inp
    v == 0
}

test_json_content_fails_with_html_violation {
    inp := {
        "headers": {
            "Content-Type": ["text/html"],
            "Server": ["apache"]
        },
        "status_code": 200,
        "success": true
    }
    v := count(policy.violation) with input as inp
    v == 1
}

test_json_content_fails_with_plain_text_violation {
    inp := {
        "headers": {
            "Content-Type": ["text/plain"],
            "Content-Length": ["100"]
        },
        "status_code": 200,
        "success": true
    }
    v := count(policy.violation) with input as inp
    v == 1
}

test_json_content_fails_missing_content_type_header_violation {
    inp := {
        "headers": {
            "Server": ["nginx"],
            "Content-Length": ["500"]
        },
        "status_code": 200,
        "success": true
    }
    v := count(policy.violation) with input as inp
    v == 1
}

test_json_content_fails_empty_headers_violation {
    inp := {
        "headers": {},
        "status_code": 200,
        "success": true
    }
    v := count(policy.violation) with input as inp
    v == 1
}