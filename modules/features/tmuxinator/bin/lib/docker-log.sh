# Shared helpers for following container logs across restarts.
# Notices go to stderr so downstream log parsers only receive log lines.

monitor_notice() {
  printf -- '-- monitor: %s --\n' "$*" >&2
}

monitor_container_running() {
  [ "$(docker inspect -f '{{.State.Running}}' "$1" 2>/dev/null)" = "true" ]
}

monitor_wait_for_container() {
  local container="$1"
  local announced=0

  until monitor_container_running "$container"; do
    if [ "$announced" -eq 0 ]; then
      monitor_notice "waiting for $container"
      announced=1
    fi
    sleep 1
  done
}

# Follows one container until its stream ends (restart, recreate, docker error).
# Always returns 0 so a lost stream never kills a caller running with pipefail.
monitor_follow_once() {
  local container="$1"
  local tail_lines="$2"

  monitor_wait_for_container "$container"
  monitor_notice "following $container"
  docker logs -f --tail "$tail_lines" "$container" 2>&1 || true
  monitor_notice "disconnected from $container"
}
