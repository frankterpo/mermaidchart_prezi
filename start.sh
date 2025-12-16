#!/bin/bash

# Configuration
PORT=8000
DIR="./presentation"

# Function to kill the background server on exit
cleanup() {
    echo ""
    echo "🛑 Shutting down..."
    if kill -0 $PID 2>/dev/null; then
        kill $PID
        echo "✅ Local server stopped."
    fi
}

# Trap Ctrl+C (SIGINT) and Exit
trap cleanup EXIT

# Parse Arguments
USE_NGROK=false
if [[ "$*" == *"--ngrok"* ]]; then
    USE_NGROK=true
fi

# 1. Start Local Server
echo "🚀 Starting local server..."
# Check if python3 is available
if command -v python3 &> /dev/null; then
    python3 -m http.server $PORT --directory $DIR &
    PID=$!
else
    echo "❌ Python3 not found. Trying python..."
    python -m SimpleHTTPServer $PORT &
    PID=$!
fi

# Wait a moment for server to start
sleep 1

if ! kill -0 $PID 2>/dev/null; then
    echo "❌ Failed to start local server. Is port $PORT in use?"
    exit 1
fi

echo "✅ Server running at http://localhost:$PORT"

# 2. Start Ngrok (Optional)
if [ "$USE_NGROK" = true ]; then
    echo "🔍 Checking for ngrok..."
    if ! command -v ngrok &> /dev/null; then
        echo "❌ ngrok not found. Please install it to use --ngrok."
        echo "   Continuing with local server only..."
    else
        echo "🔗 Starting ngrok tunnel..."
        echo "ℹ️  Press Ctrl+C to stop everything."
        echo ""
        ngrok http $PORT
    fi
else
    echo "ℹ️  Running locally. Use './start.sh --ngrok' to share."
    # Wait indefinitely since we aren't running a foreground process like ngrok
    wait $PID
fi
