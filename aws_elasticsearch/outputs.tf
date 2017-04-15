output "endpoint" {
	value =" ${aws_elasticsearch_domain.es.endpoint}"
}
output "kibana" {
	value = "${aws_elasticsearch_domain.es.endpoint}/_plugin/kibana/"
}