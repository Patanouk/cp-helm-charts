# Forward kafka cluster from Kubernetes to localhost

The goal of this fork was to be able to port-forward the kafka cluster in the kubernetes cluster locally

##Changes in the chart

```yaml
  # See values.yaml in charts/cp-kafka/values.yaml
  configurationOverrides:
    "advertised.listeners": |-
      KUBERNETESPORTFOWARD://localhost:$((29092 + ${KAFKA_BROKER_ID}))
    "listener.security.protocol.map": |-
      PLAINTEXT:PLAINTEXT,KUBERNETESPORTFOWARD:PLAINTEXT
```

## How to port-forward
See [kafka-port-forward-local.sh](./kafka-port-forward-local.sh) for a script doing the port-forwarding

## Additional documentations on Kafka listeners

####Blog article explaining the kafka listeners
https://www.confluent.io/blog/kafka-listeners-explained/

####Github Issue detailing how to port-forward the kafka cluster in the cp-helm chart
https://github.com/confluentinc/cp-helm-charts/issues/351