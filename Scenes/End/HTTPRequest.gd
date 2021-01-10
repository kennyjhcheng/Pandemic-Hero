extends HTTPRequest


var my_full_url = "https://docs.google.com/forms/d/e/1FAIpQLScJC3_by4bZi-EPrpnOPG2v93HD_f7TPAXRB1jHUp9su26v1A/formResponse"


var http = HTTPClient.new()



	
func send_data(data):
	var headers = ["Content-Type: application/x-www-form-urlencoded"]
	print(data)
	var headers_pool = PoolStringArray(headers)
	var my_data_ready = http.query_string_from_dict(data)
	
	self.request(my_full_url, headers_pool, false, http.METHOD_POST, my_data_ready)
	


	
	



func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	print(result,response_code)
