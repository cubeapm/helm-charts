# CubeAPM Helm Charts

[Helm](https://github.com/helm/helm) charts to deploy CubeAPM on k8s.

## Usage

Add the repo as follows:

    helm repo add cubeapm https://charts.cubeapm.com

If you had already added this repo earlier, run `helm repo update` to retrieve
the latest versions of the packages. You can then run `helm search repo cubeapm` to see the charts.

To install the cubeapm chart:

    helm install my-cubeapm cubeapm/cubeapm

To update an existing cubeapm installation:

    helm upgrade my-cubeapm cubeapm/cubeapm

To uninstall the chart:

    helm delete my-cubeapm

## Configuration

Follow [README of CubeAPM helm chart](./charts/cubeapm/README.md).
