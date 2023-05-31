{{/*
Expand the name of the chart.
*/}}
{{- define "cubeapm.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "cubeapm.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "cubeapm.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "cubeapm.labels" -}}
helm.sh/chart: {{ include "cubeapm.chart" . }}
{{ include "cubeapm.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "cubeapm.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cubeapm.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "cubeapm.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "cubeapm.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Cubeapm image name
*/}}
{{- define "cubeapm.image" -}}
{{- $registryName := default .Values.image.registry .Values.global.imageRegistry -}}
{{- $repositoryName := .Values.image.repository -}}
{{- $tag := default .Chart.AppVersion .Values.image.tag | toString -}}
{{- if $registryName -}}
{{- printf "%s/%s:%s" $registryName $repositoryName $tag }}
{{- else -}}
{{- printf "%s:%s" $repositoryName $tag }}
{{- end -}}
{{- end -}}


{{/*
Image pull secrets
*/}}
{{- define "cubeapm.imagePullSecrets" -}}
{{- if or .Values.global.imagePullSecrets .Values.imagePullSecrets }}
imagePullSecrets:
{{- range .Values.global.imagePullSecrets }}
  - name: {{ . }}
{{- end }}
{{- range .Values.imagePullSecrets }}
  - name: {{ . }}
{{- end }}
{{- end }}
{{- end }}
