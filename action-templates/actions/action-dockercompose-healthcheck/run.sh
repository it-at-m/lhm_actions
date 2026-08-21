#!/usr/bin/env bash
set -euo pipefail

MAX_RETRIES="${MAX_RETRIES:-10}"
RETRY_INTERVAL="${RETRY_INTERVAL:-10}"
COMPOSE_FILE_NAME="${COMPOSE_FILE_NAME:-"docker-compose.yml"}"

retry_count=0

while ((retry_count < MAX_RETRIES)); do
    failed_services=()
    pending_services=()

    retry_count=$((retry_count+1))

    # Query all services once.
    ps_output="$(
        docker compose -f "$COMPOSE_FILE_NAME" ps -a --format '{{.Service}};{{.State}};{{.Health}};{{.ExitCode}}'
    )"

    while IFS=$';' read -r service status health exit_code; do
        [[ -z "$service" ]] && continue

        if [[ "$status" == "running" ]]; then
            if [[ "$health" == "unhealthy" ]]; then
                failed_services+=("$service (unhealthy)")
            elif [[ -n "$health" && "$health" != "healthy" ]]; then
                pending_services+=("$service (health: $health)")
            fi

        elif [[ "$status" == "exited" ]]; then
            if [[ "$exit_code" != "0" ]]; then
                failed_services+=("$service (exited with status $exit_code)")
            fi

        else
            pending_services+=("$service ($status)")
        fi
    done <<< "$ps_output"

    if ((${#failed_services[@]} > 0)); then
        echo "Services failed (attempt ${retry_count}/${MAX_RETRIES}):" >&2
        printf '  %s\n' "${failed_services[@]}" >&2
        exit 1

    elif ((${#pending_services[@]} == 0)); then
        echo "All services are ready."
        exit 0

    else
        echo "Services pending (attempt ${retry_count}/${MAX_RETRIES}):" >&2
        printf '  %s\n' "${pending_services[@]}" >&2
    fi

    if ((retry_count < MAX_RETRIES)); then
        sleep "$RETRY_INTERVAL"
    fi
done

echo "Maximum retries (${MAX_RETRIES}) reached. Exiting with status code 1." >&2
exit 1