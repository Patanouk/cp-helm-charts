#!/bin/bash

kafka_release_name="confluent-kafka"
namespace="default"

printf "Forwarding kafka from cluster $(kubectl config current-context) in namespace %s to localhost:29092\n\n" $namespace

index=0
for kafka_broker in $(kubectl get pods -n "$namespace" -l release="$kafka_release_name" -l app=cp-kafka -o Name | sort); do
  echo "Forwarding $kafka_broker:$((29092 + index)) to localhost:$((29092 + index))"
  kubectl -n $namespace port-forward "$kafka_broker" $((29092 + index)) &
  index=$((index + 1))
done

sleep 3
printf "\n Kafka port-forwarding is ongoing. Ctrl+c to stop"
wait