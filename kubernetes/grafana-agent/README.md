# Grafana agent

Grafana agent configuration instructions give you clear instructions on how to deploy a new grafana agent in any k8s cluster.

Just go to Grafana welcome page, then click on Kubernetes Monitoring and click on Configuration to access their guide.

## Monitoring

It is very important that you remember that every monitoring related pods are created in the monitoring namespace. In this case, it needs to be specified during the grafana agent setup, don't worry it will be stated in their instruction guide.

## Installation

```
kubectl apply -f agent-configmap.yaml
kubectl apply -f agent-bare.yaml
kubectl apply -f agent-log-configmap.yaml
kubectl apply -f agent-loki.yaml
```

If you upgrade configmaps, you need to delete the deployment manually and redeploy them

```
kubectl delete -f agent-bare.yaml
kubectl delete -f agent-loki.yaml
kubectl apply -f agent-bare.yaml
kubectl apply -f agent-loki.yaml
```
- https://phoenixnap.com/kb/prometheus-kubernetes-monitoring

- https://prometheus.io/docs/prometheus/2.34/configuration/configuration/#metric_relabel_configs

## Metrics kept

- kube_job_status_active
- kube_job_status_start_time
- kube_deployment_status_replicas_updated
- node_namespace_pod_container:container_memory_rss
- namespace_workload_pod
- kube_statefulset_status_replicas_ready
- kube_job_failed
- kubelet_runtime_operations_errors_total
- container_memory_working_set_bytes
- container_fs_reads_bytes_total
- cluster:namespace:pod_memory:active:kube_pod_container_resource_requests
- node_namespace_pod_container:container_cpu_usage_seconds_total:sum_irate
- namespace_cpu:kube_pod_container_resource_limits:sum
- kube_daemonset_status_updated_number_scheduled
- kube_daemonset_status_number_available
- rest_client_requests_total
- kubelet_pleg_relist_duration_seconds_bucket
- container_memory_rss
- kube_pod_status_phase
- node_namespace_pod_container:container_memory_cache
- container_memory_cache
- container_memory_swap
- kube_pod_container_resource_limits
- kube_pod_info
- kube_statefulset_status_current_revision
- kube_node_spec_taint
- process_cpu_seconds_total
- container_cpu_cfs_throttled_periods_total
- kube_daemonset_status_current_number_scheduled
- kube_horizontalpodautoscaler_status_desired_replicas
- kube_node_status_capacity
- kubelet_running_containers
- kubelet_pod_worker_duration_seconds_count
- kubelet_node_config_error
- kube_node_info
- storage_operation_errors_total
- kubelet_volume_stats_capacity_bytes
- kubelet_volume_stats_inodes_used
- namespace_workload_pod:kube_pod_owner:relabel
- kubelet_certificate_manager_server_ttl_seconds
- go_goroutines
- kube_node_status_allocatable
- kube_horizontalpodautoscaler_spec_min_replicas
- kubelet_certificate_manager_client_expiration_renew_errors
- kubelet_pod_worker_duration_seconds_bucket
- volume_manager_total_volumes
- kubelet_volume_stats_available_bytes
- cluster:namespace:pod_memory:active:kube_pod_container_resource_limits
- kubelet_volume_stats_inodes
- namespace_cpu:kube_pod_container_resource_requests:sum
- kube_statefulset_status_update_revision
- kubelet_running_pod_count
- node_namespace_pod_container:container_memory_swap
- storage_operation_duration_seconds_count
- kube_statefulset_status_replicas
- kubelet_runtime_operations_total
- cluster:namespace:pod_cpu:active:kube_pod_container_resource_limits
- namespace_memory:kube_pod_container_resource_limits:sum
- kubelet_server_expiration_renew_errors
- container_fs_reads_total
- kubelet_pleg_relist_duration_seconds_count
- container_fs_writes_total
- kubelet_certificate_manager_client_ttl_seconds
- node_namespace_pod_container:container_memory_working_set_bytes
- kube_namespace_status_phase
- kube_statefulset_replicas
- kube_pod_owner
- kube_statefulset_metadata_generation
- kube_deployment_metadata_generation
- cluster:namespace:pod_cpu:active:kube_pod_container_resource_requests
- kube_deployment_status_replicas_available
- kubernetes_build_info
- kube_replicaset_owner
- kubelet_running_pods
- kube_daemonset_status_number_misscheduled
- kube_deployment_status_observed_generation
- kubelet_cgroup_manager_duration_seconds_bucket
- kubelet_running_container_count
- container_cpu_cfs_periods_total
- kube_horizontalpodautoscaler_spec_max_replicas
- kube_statefulset_status_observed_generation
- kube_node_status_condition
- container_cpu_usage_seconds_total
- up
- process_resident_memory_bytes
- kube_resourcequota
- kube_horizontalpodautoscaler_status_current_replicas
- kube_deployment_spec_replicas
- node_quantile:kubelet_pleg_relist_duration_seconds:histogram_quantile
- kubelet_pod_start_duration_seconds_count
- machine_memory_bytes
- kube_statefulset_status_replicas_updated
- kube_daemonset_status_desired_number_scheduled
- kubelet_cgroup_manager_duration_seconds_count
- kube_pod_container_resource_requests
- container_fs_writes_bytes_total
- namespace_memory:kube_pod_container_resource_requests:sum
- kubelet_pleg_relist_interval_seconds_bucket
- kubelet_node_name
- kube_pod_container_status_waiting_reason
- kube_namespace_status_phase
- container_cpu_usage_seconds_total
- kube_pod_status_phase
- kube_pod_start_time
- kube_pod_container_status_restarts_total
- kube_pod_container_info
- kube_pod_container_status_waiting_reason
- kube_daemonset.*
- kube_replicaset.*
- kube_statefulset.*
- kube_job.*

## Metrics dropped

- container_network_receive_bytes_total
- container_network_transmit_bytes_total
- container_network_receive_packets_dropped_total
- container_network_transmit_packets_dropped_total
- container_network_transmit_packets_total
- container_network_receive_packets_total