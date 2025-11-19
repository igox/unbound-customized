#!/bin/sh
# Robust Unbound healthcheck

SERVER="127.0.0.1"
DOMAINS="cloudflare.com google.com quad9.net"
RETRIES=3
SLEEP=1

for DOMAIN in $DOMAINS; do
    for i in $(seq 1 $RETRIES); do
        # Run DNS query silently and capture exit code
        OUTPUT=$(drill "$DOMAIN" @"$SERVER" 2>&1)
        STATUS=$?

        # If drill failed to execute or connect
        if [ $STATUS -ne 0 ]; then
            sleep $SLEEP
            continue
        fi

        # Verify Unbound returns an answer section
        echo "$OUTPUT" | grep -q "ANSWER SECTION"
        if [ $? -eq 0 ]; then
            exit 0
        fi

        sleep $SLEEP
    done

    # All retries failed
    # Kill unbound to trigger container restart
    echo "Healthcheck failed — killing unbound to trigger container restart."
    pkill unbound || kill 1
    exit 1
done