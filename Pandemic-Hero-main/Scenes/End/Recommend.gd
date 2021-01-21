extends HTTPRequest


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var http = HTTPClient.new()
var recommendationUrl = "https://dicovserver.gottacatchemall.repl.co/recommend"





func reccomend(data):
	var headers = ["Content-Type: application/json"]
	var query = JSON.print(data)
	var headers_pool = PoolStringArray(headers)
#	var my_data_ready = http.query_string_from_dict(data)
	self.request(recommendationUrl, headers_pool, false, http.METHOD_POST,query)
	
