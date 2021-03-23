map Writer.getConnection(map request)
{
	service = Service_Link[reference == "zohoapis"];
	connection = Map();
	connection.put("apiUri","https://writer.zoho.com/api/v1/documents/");
	headers = Map();
	//if(!isBlank(service.auth_token) && zoho.currenttime < service.Modified_Time.addMinutes(30))
	if(false)
	{
		headers.put("Authorization","Zoho-oauthtoken " + service.auth_token);
	}
	else
	{
		url = service.api_uri + "?" + service.kwargs;
		response = postUrl(url,"",false);
		if(response.get("responseCode") == 200)
		{
			service.auth_token=response.get("responseText").getJSON("access_token");
			headers.put("Authorization","Zoho-oauthtoken " + response.get("responseText").getJSON("access_token"));
		}
		else
		{
			service.Interface=response.get("responseText");
			connection.put("error",response.get("responseText"));
		}
	}
	connection.put("headers",headers);
	if(request.containKey("folderName"))
	{
		folders = service.Settings.getJSON("folders");
		connection.put("folderId",folders.getJSON(request.get("folderName")));
	}
	return connection;
}