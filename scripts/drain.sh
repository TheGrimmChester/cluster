#!/bin/bash

KUBECTL="/usr/local/bin/kubectl"

NOT_READY_NODES=$($KUBECTL get nodes | grep  'NotReady' | awk '{print $1}')

while IFS= read -r line; do
	if [[ ! $line =~ [^[:space:]] ]] ; then
  		continue
	fi
	echo "Found $line node to be dead, draining..."
	$KUBECTL drain --ignore-daemonsets --force $line
done <<< "$NOT_READY_NODES"

READY_NODES=$(kubectl get nodes | grep '\sReady,SchedulingDisabled' | awk '{print $1}')

while IFS= read -r line; do
	if [[ ! $line =~ [^[:space:]] ]] ; then
  		continue
	fi
	echo "Found $line node to be online again, undraining..."
	$KUBECTL uncordon $line
done <<< "$READY_NODES"
