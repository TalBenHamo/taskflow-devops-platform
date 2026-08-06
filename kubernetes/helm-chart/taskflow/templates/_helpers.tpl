{{- define "taskflow.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "taskflow.fullname" -}}
{{- printf "%s-%s" .Release.Name (include "taskflow.name" .) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "taskflow.labels" -}}
app.kubernetes.io/name: {{ include "taskflow.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version }}
{{- end }}
