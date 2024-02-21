#!/bin/bash

max_usage=${1:-50}

echo "current usage:"
oc rsh -n openshift-storage $(oc get pods -n openshift-storage -l app=rook-ceph-tools -o name) ceph osd df

osd_ids=$(oc rsh -n openshift-storage $(oc get pods -n openshift-storage -l app=rook-ceph-tools -o name) ceph osd df -f json |jq ".nodes[] | select(.utilization>$max_usage) | .id")

if [[ -n $osd_ids ]]; then
  for osd in $osd_ids; do
    echo "killing osd instance $osd"
    oc -n openshift-storage delete $(oc get pod -n openshift-storage --selector app.kubernetes.io/instance=$osd -o name)
  done
fi