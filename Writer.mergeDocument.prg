map Writer.mergeDocument(map request)
{
	connection = thisapp.Writer.getConnection(Map({"folderName":request.get("folderName")}));
	if(connection.containKey("error"))
	{
		return connection;
	}
	headers = connection.get("headers").toMap();
	url = request.get("templateUrl") + "/merge/store";
	templateID = request.get("templateUrl").getsuffix("documents/");
	data = Map();
	output = Map();
	output.put("doc_name",request.get("fileName"));
	output.put("folder_id",connection.get("folderId"));
	data.put("output_settings",output.toString());
	data.put("merge_data",request.get("mergeData").toString());
	webRequest = Map();
	webRequest.put("url",url);
	webRequest.put("method","post");
	webRequest.put("headers",headers);
	webRequest.put("body",data.toString());
	response = thisapp.Web.invokeUrl(webRequest);
	//info response;
	//info url;
	//info headers;
	//info data.toString();
	//response = postUrl(url,data,headers,false);
	//response = zoho.writer.mergeAndStore(templateID, request.get("mergeData").get("data"), output, "zoho_writer");
	request.remove("mergeData");
	if(response.get("responseCode") == 200 && !response.get("responseText").toMap().containKey("error"))
	{
		documentId = response.get("responseText").toMap().get("document_id");
		url = "https://writer.zoho.com/api/v1/documents/" + documentId + "/publish?scope=external";
		response = postUrl(url,Map(),headers,false);
		//info response;
		if(response.get("responseCode") == 200 && response.get("responseText").getJSON("result") == "success")
		{
			request.put("documentId",documentId);
			request.put("publicUrl",response.get("responseText").getJSON("published_url"));
			request.put("downloadUrl","https://writer.zoho.com/api/v1/documents/" + documentId + "?format=pdf");
		}
		else
		{
			request.put("error",response.get("responseText"));
		}
	}
	else
	{
		request.put("error",response.get("responseText"));
	}
	return request;
}