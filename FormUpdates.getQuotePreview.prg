map FormUpdates.getQuotePreview(map request)
{
	// Test Job ID: 1886330000037636976
	// Send Email Workflow request: {"query":{"job_id":"1886330000055572055","document_name":"Quote.pdf","merge_mode":"live", "isRequestOnly":true}}
	query = request.get("query").toMap();
	job_id = query.get("job_id");
	document_type = if(query.containKey("document_type"),query.get("document_type"),"pdf");
	// get quote and template parameters
	// DEBUG MODE
	jobRec = Jobs[ID == job_id.toLong()];
	template_url = "";
	if(!isBlank(jobRec.Quote_Format.toString()) && jobRec.Quote_Format.Template_Format == "MS Word")
	{
		template_url = if(document_type == "docx",jobRec.Quote_Format.WordDocx_URL,jobRec.Quote_Format.WebMerge_URL);
	}
	else if(!isBlank(jobRec.Service_Location.Quote_Format.toString()) && jobRec.Service_Location.Quote_Format.Template_Format == "MS Word")
	{
		template_url = if(document_type == "docx",jobRec.Service_Location.Quote_Format.WordDocx_URL,jobRec.Service_Location.Quote_Format.WebMerge_URL);
	}
	else if(!isBlank(jobRec.Company_Info_ID.Quote_Format.toString()) && jobRec.Company_Info_ID.Quote_Format.Template_Format == "MS Word")
	{
		template_url = if(document_type == "docx",jobRec.Company_Info_ID.Quote_Format.WordDocx_URL,jobRec.Company_Info_ID.Quote_Format.WebMerge_URL);
	}
	if(isBlank(template_url))
	{
		info "getQuotePreview ERROR - Blank Template";
		return Map();
	}
	document_path = "goscaffold/prod/customers/" + jobRec.Company_Info_ID + "/quotes/";
	document_name = if(query.containKey("document_name"),request.get("document_name"),job_id);
	merge_data = thisapp.FormUpdates.getQuote(request);
	merge_mode = if(query.containKey("merge_mode"),query.get("merge_mode"),"live");
	//info merge_mode;
	// merge dodument
	merge_request = Map();
	merge_request.put("template_url",template_url);
	merge_request.put("document_path",document_path);
	//merge_request.put("document_name",jobRec.Job_Reference.replaceAll(" ","_"));
	merge_request.put("document_name",job_id);
	merge_request.put("document_type",document_type);
	merge_request.put("merge_mode",merge_mode);
	merge_request.put("merge_data",merge_data);
	if(query.containKey("isRequestOnly"))
	{
		merge_request.put("isRequestOnly",true);
	}
	response = thisapp.docs.mergeDocument(Map({"query":merge_request}));
	if(request.containKey("preview_open") && request.get("preview_open"))
	{
		if(response.get("responseCode") == 200)
		{
			openUrl(response.get("responseText"),"same window");
		}
		else
		{
			system_alert = Map();
			system_alert.put("type","error");
			system_alert.put("text",response.get("responseText"));
			url = "#Form:System_Alert?zc_LoadIn=dialog&sc_SystemMessage=" + encodeUrl(system_alert.toString());
			openUrl(url,"same window");
			response.put("responseText",url);
		}
	}
	return response;
}