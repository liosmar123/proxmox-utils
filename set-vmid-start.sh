#!/bin/bash

CFG_FILE="/etc/pve/datacenter.cfg"

# Must run as root
if [[ $EUID -ne 0 ]]; then
  echo "❌ This script must be run as root."
  exit 1
fi

# Ask for new lower ID
read -p "👉 Enter the new starting VMID (e.g. 200): " LOWER

# Validate input
if [[ ! $LOWER =~ ^[0-9]+$ ]]; then
  echo "❌ Invalid input. A number is required."
  exit 1
fi

UPPER=1000000  # Safe upper limit

# Backup current config
BACKUP="${CFG_FILE}.bak.$(date +%F-%H%M%S)"
cp "$CFG_FILE" "$BACKUP"
echo "📦 Backup of datacenter.cfg saved as $BACKUP"

# Remove existing 'next-id' line if present
sed -i '/^next-id:/d' "$CFG_FILE"

# Append new configuration
echo "next-id: lower=$LOWER,upper=$UPPER" >> "$CFG_FILE"

echo "✅ Updated 'datacenter.cfg' with:"
echo "next-id: lower=$LOWER,upper=$UPPER"
echo

# Show updated file
echo "📄 Current content of datacenter.cfg:"
cat "$CFG_FILE"
echo

# Show the new next available VMID
echo "🔍 Next available VMID is now:"
pvesh get /cluster/nextid
