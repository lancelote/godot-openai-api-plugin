extends Node


var api_key := ""
var model := "gpt-4.1"
var url := "https://api.openai.com/v1/responses"


func load_api_key_from_env() -> void:
	api_key = OS.get_environment("OPENAI_API_KEY")
	if api_key.is_empty():
		push_error("OpenAI API key is not set")


func request() -> void:
	var http := HTTPRequest.new()
	add_child(http)
	http.request_completed.connect(_http_request_completed)
	
	load_api_key_from_env()
	
	var headers := [
		"Content-Type: application/json",
		"Authorization: Bearer %s" % api_key
	]

	var data := {
		"model": model,
		"input": "Write a one-sentence bedtime story about a unicorn."
	}
	var body := JSON.stringify(data)
	
	var error = http.request(url, headers, HTTPClient.METHOD_POST, body)
	if error != OK:
		push_error("an error occured during HTTP request")


func _http_request_completed(result, response_code, headers, body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())
	var response = json.get_data()
	print(response)
