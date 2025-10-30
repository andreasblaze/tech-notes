---
sidebar_position: 2
---
# Prometheus

## How to delete the PVC (volume) before terraform apply
### Scale down Prometheus
```bash
kubectl -n <namespace> get sts
```
```bash
kubectl -n <namespace> scale statefulset prometheus --replicas=0
```
### Delete the PVC
```bash
kubectl -n <namespace> get pvc
```
```bash
kubectl -n <namespace> delete pvc data-prometheus-0
```

## Data
```js
volume_mount {
  name       = "data"
  mount_path = "/data"
}
```
is mounting a persistent volume (**PVC**) into the Prometheus container at the path `/data`, which is where Prometheus stores its local time series data (**TSDB**).
:::info
`/data` is the default storage location for TSDB.
*--storage.tsdb.path=/data*
:::
Prometheus buffers all incoming data to disk before forwarding it via `remote_write`(VictoriaMetrics). And this protects against `remote_write` failure.