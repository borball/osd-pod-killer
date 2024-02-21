## create cronjob

```shell
oc apply -f service-account.yaml
oc apply -f cluster-role-binding.yaml
oc apply -f osd-pod-killer-cronjob.yaml
```

## Check logs

Following is a test logs which deleted pods if %USE exceeds 0.42%:

```shell
# oc logs osd-pod-killer-28475883-d9kfr
current usage:
ID  CLASS  WEIGHT   REWEIGHT  SIZE     RAW USE  DATA      OMAP     META     AVAIL    %USE  VAR   PGS  STATUS
 2    hdd  0.09769   1.00000  100 GiB  440 MiB   340 MiB  288 KiB  100 MiB  100 GiB  0.43  1.01  353      up
 0    hdd  0.09769   1.00000  100 GiB  437 MiB   340 MiB  288 KiB   97 MiB  100 GiB  0.43  1.01  353      up
 1    hdd  0.09769   1.00000  100 GiB  427 MiB   340 MiB  537 KiB   86 MiB  100 GiB  0.42  0.98  353      up
                       TOTAL  300 GiB  1.3 GiB  1019 MiB  1.1 MiB  282 MiB  299 GiB  0.42
MIN/MAX VAR: 0.98/1.01  STDDEV: 0.01
killing osd instance 2
pod "rook-ceph-osd-2-6b6cfc5df5-8ng4w" deleted
killing osd instance 0
pod "rook-ceph-osd-0-5d4fb9976b-vvxng" deleted

```

```shell
#oc get pod -w
osd-pod-killer-28475883-d9kfr                                     0/1     Pending     0          0s
osd-pod-killer-28475883-d9kfr                                     0/1     Pending     0          0s
osd-pod-killer-28475883-d9kfr                                     0/1     Pending     0          0s
osd-pod-killer-28475883-d9kfr                                     0/1     ContainerCreating   0          0s
osd-pod-killer-28475883-d9kfr                                     0/1     ContainerCreating   0          0s
osd-pod-killer-28475883-d9kfr                                     1/1     Running             0          2s
rook-ceph-osd-2-6b6cfc5df5-8ng4w                                  2/2     Terminating         0          60m
rook-ceph-osd-2-6b6cfc5df5-gxw8d                                  0/2     Pending             0          0s
rook-ceph-osd-2-6b6cfc5df5-gxw8d                                  0/2     Pending             0          0s
rook-ceph-osd-2-6b6cfc5df5-gxw8d                                  0/2     Pending             0          0s
rook-ceph-osd-2-6b6cfc5df5-gxw8d                                  0/2     Init:0/4            0          0s
rook-ceph-osd-2-6b6cfc5df5-gxw8d                                  0/2     Init:0/4            0          1s
rook-ceph-osd-2-6b6cfc5df5-gxw8d                                  0/2     Init:1/4            0          2s
rook-ceph-osd-2-6b6cfc5df5-8ng4w                                  0/2     Terminating         0          60m
rook-ceph-osd-2-6b6cfc5df5-8ng4w                                  0/2     Terminating         0          60m
rook-ceph-osd-2-6b6cfc5df5-8ng4w                                  0/2     Terminating         0          60m
rook-ceph-osd-0-5d4fb9976b-vvxng                                  2/2     Terminating         0          55m
rook-ceph-osd-0-5d4fb9976b-krttn                                  0/2     Pending             0          0s
rook-ceph-osd-0-5d4fb9976b-krttn                                  0/2     Pending             0          0s
rook-ceph-osd-0-5d4fb9976b-krttn                                  0/2     Init:0/4            0          0s
rook-ceph-osd-0-5d4fb9976b-krttn                                  0/2     Init:0/4            0          0s
rook-ceph-osd-0-5d4fb9976b-krttn                                  0/2     Init:0/4            0          1s
rook-ceph-osd-2-6b6cfc5df5-gxw8d                                  0/2     Init:2/4            0          3s
rook-ceph-osd-2-6b6cfc5df5-gxw8d                                  0/2     Init:2/4            0          4s
rook-ceph-osd-0-5d4fb9976b-vvxng                                  0/2     Terminating         0          55m
rook-ceph-osd-0-5d4fb9976b-vvxng                                  0/2     Terminating         0          55m
rook-ceph-osd-0-5d4fb9976b-vvxng                                  0/2     Terminating         0          55m
rook-ceph-osd-0-5d4fb9976b-krttn                                  0/2     Init:1/4            0          2s
osd-pod-killer-28475883-d9kfr                                     0/1     Completed           0          7s
rook-ceph-osd-2-6b6cfc5df5-gxw8d                                  0/2     Init:3/4            0          5s
rook-ceph-osd-0-5d4fb9976b-krttn                                  0/2     Init:2/4            0          3s
rook-ceph-osd-2-6b6cfc5df5-gxw8d                                  0/2     PodInitializing     0          6s
rook-ceph-osd-0-5d4fb9976b-krttn                                  0/2     Init:2/4            0          4s
rook-ceph-osd-2-6b6cfc5df5-gxw8d                                  1/2     Running             0          7s
osd-pod-killer-28475883-d9kfr                                     0/1     Completed           0          9s
rook-ceph-osd-0-5d4fb9976b-krttn                                  0/2     Init:3/4            0          5s
osd-pod-killer-28475883-d9kfr                                     0/1     Completed           0          10s
rook-ceph-osd-0-5d4fb9976b-krttn                                  0/2     PodInitializing     0          6s
rook-ceph-osd-0-5d4fb9976b-krttn                                  1/2     Running             0          7s
rook-ceph-osd-2-6b6cfc5df5-gxw8d                                  1/2     Running             0          21s
rook-ceph-osd-2-6b6cfc5df5-gxw8d                                  2/2     Running             0          21s
rook-ceph-osd-0-5d4fb9976b-krttn                                  1/2     Running             0          21s
rook-ceph-osd-0-5d4fb9976b-krttn                                  2/2     Running             0          21s
```