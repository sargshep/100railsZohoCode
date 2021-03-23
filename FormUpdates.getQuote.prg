FormUpdates.getQuote(map request)
{
	/*
Quote JSON object structure
{
	"data": {
		"type": "quote",
		"id": "<jobRec.ID>",
		"attributes": {
			"quote_number", "<jobRec.Quote_Job_Number>",
			"revision_number": "<jobRec.Quote_Revision_Number>",
			"job_reference", "<jobRec.Job_Reference>",
			"job_stage": "<jobRec.Job_Stage.Full_Stage_Name>", // TODO: replace with {} with attributes
			"followup_status": "<jobRec.FUP_Status>",
			"client": {
				"type": "client",
				"id": "<jobRec.Related_Client>",
				"attributes": {
					"status": "<cliRec.Status>",
					"company_name": "<cliRec.Organisation_Name>",
					"full_name": "<cliRec.Full_Name>",
					"email": "<cliRec.Main_Email>",
					"phone",
					"website",
					"postal_address": "<cliRec.Address>",
					"due_date_terms": "<cliRec.Due_Date_Terms>",
					"company_logo": "clieRec.Client_Logo"
				}
			},
			"quoting_contacts": [
				{
					"type": "client_contact",
					"id": "<jobRec.Contacts_Quoting[]>",
					"attributes": {
						"full_name": "<cliConRec.Full_Name>",
						"email": "<cliConRec.Email>",
						"mobile_phone": "<cliConRec.Cell_Phone>"
					}
				}
			],
			"site_contacts": [
				{
					"type": "client_contact",
					"id": "<jobRec.Site_Contacts[]>",
					"attributes": {
						"full_name": "<cliConRec.Full_Name>",
						"email": "<cliConRec.Email>",
						"mobile_phone": "<cliConRec.Cell_Phone>"
					}
				}
			],
			"quote_manager": {
				"type": "staff",
				"id": "<jobRec.Quote_Manager>",
				"attributes": {
					"full_name"" "<staRec.Full_Name>",
					"phone": "<staRec.Cell_Phone>",
					"email": "<staRec.Email>",
					"title": "<staRec.Staff_Roles_Assigned.Role_Name>"
				}			
			},
			"work_site_address": "<jobRec.Work_Site_Address>",  // will be repalced by "site_address"
			"site_address": {
				"address_line1": "<jobRec.Site_Address.address_line_12>",
				"address_line1": "<jobRec.Site_Address.address_line_22>",
				"disctrict_city": "<jobRec.Site_Address.disctrict_city2>",
				"state_province": "<jobRec.Site_Address.state_province2>",
				"country": "<jobRec.Site_Address.country2>",
				"postal_code": "<jobRec.Site_Address.postal_Code2>",
				"latitude": "<jobRec.Site_Address.latitude2>",
				"longitude": "<jobRec.Site_Address.longitude2>"
			},
			"quote_comments": "<jobRec.QuotesComment>",
			"quote_scope": "<jobRec.Quote_Text>",
			"quote_text": "<jobRec.Quote_Text_2Word>",  // convert multi-line to JSON with text2json lambda
			"project_specifications": "<jobRec.Project_Specifications>",  // convert multi-line to JSON with text2json lambda
			"duty_loading": "<jobRec.Scaf_Duty_Loading>",
			"enquiry_date": "<jobRec.Is_Enquiry_Date>",
			"start_date": "<jobRec.Est_Start_Date>",
			"finish_date": "<jobRec.Est_Finish_Date>",
			"quote_date": "<jobRec.Is_Quoted_Date> || <jobRec.Added_Time>",
			"revision_date": "<jobRec.Revised_Sent_Date>",
			"valid_date": "(<jobRec.Is_Quoted_Date> || <jobRec.Revised_Sent_Date>) + <jobRec.Company_Info_ID.Quote_Valid_Days>"
			"win_date": "<jobRec.Is_Job_Won_Date>",
			"lost_date": "<jobRec.Is_Job_Lost_Date>",
			"lost_reason": "<jobRec.Lost_Reason>",
			"lost_comment": "<jobRec.Lost_Comment>",
			"photos": [
				"<jobRec.Photo_1>",  // TODO: convert to downloadable URL
				...
				"<jobRec.Photo_15>"
			],
			"documents": [
				"<jobRec.Job_Document_1>",  // TODO: convert to downloadable URL
				...
				"<jobRec.Job_Document_15>"
			],
			"phases": [
				{
					"type": "phase",
					"id": "<phaRec.ID>",
					"attributes": {
						"phase_number": "<phaRec.Phase>",
						"phase_name": "<phaRec.Phase_Name>",
						"phase_description": "<phaRec.Phase_Description>",
						"start_date": "<phaRec.Est_Start>",
						"finish_date": "<phaRec.Est_End>",
						"hours": "<phaRec.Est_Hours>",
						"hire_weeks": "<phaRec.Est_Weeks_of_Hire>",
						"sqm": "<phaRec.Est_SQM>",
						"quote_lines": [
							{
								"type": "quote_line",
								"id": "<qteRec.ID>",
								"attributes": {
									"product": {
										"type": "product",
										"id": "<qteRec.Related_Product>",
										"attributes": {
											"product_code": "<pdtRec.Product_Code>",
											"product_name": "<pdtRec.Product_Name>",
											"product_type": "<pdtRec.Product_Type>",
											"product_category": "",  // so called Column Type in quote proposal
											"unit_type": "<pdtRec.Unit_Type>",
											"unit_price": "<pdtRec.Unit_Price>"
										}
									},
									"description": "<qteRec.Product_Description>",
									"quantity": "<qteRec.Qty>",
									"price_unit": "<qteRec.Unit_Price>",
									"price_total": "<qteRec.Unit_Total>",
								}
							}
						],
						"product_type_subtotals": "",
						"product_category_subtotals": "",
						"phase_total": ""
					}
				}
			],
			"phases_count": "",
			"quote_total": "",
			"quote_tax": "",
			"quote_total_with_tax": "",
			"quote_hire_daily": ""
		},
		"relationships": {
			"company": {
				"data": {
					"type": "company",
					"id": "<jobRec.Company_Info_ID>"
				}
			},
			"location": {
				"data": {
					"type": "location",
					"id": "<jobRec.Service_Location>"
				}
			},
			"quote_manager": {
				"data": {
					"type": "staff",
					"id": "<jobRec.Quote_Manager>"
				}
			},
			"client": {
				"data": {
					"type": "client",
					"id": "<jobRec.Related_Client>"
				}
			}
		},
	}
}
*/
	file_download_uri = "https://creatorexport.zoho.com/file/100rails/goscaffold/CLIENTS_List_Public/";
	public_token = "VZsS6vX1dbP03GNsXPKCAqk10nNxmJgEPuArePKVmtEfBWWNkf1wZTmz9OOmm0SO025yU7h1DkNNRuWsTx7PE6288pDOQdVJfnVU";
	// text2json API
	text2json_url = "https://uf9k5onq81.execute-api.ap-southeast-2.amazonaws.com/Prod/text2json_zw";
	//
	response = Map();
	if(!request.containKey("query"))
	{
		return response;
	}
	// ProductType => ColumnType mapping
	product2column = Map({"HRL":"labour","ONE":"labour","HRC":"contract_hire","CON":"consumables","DAY":"hire_day","GER":"hire_day","WKY":"hire_week","WK5":"hire_week5day","WK9":"hire_week9day","MTH":"hire_month","TRA":"transport"});
	// construct Quote JSON object
	query = request.get("query").toMap();
	job_id = query.get("job_id");
	jobRec = Jobs[ID == job_id];
	//
	data = Map();
	data.put("type","quote");
	data.put("id",job_id);
	//
	attributes = Map();
	attributes.put("quote_number",jobRec.Quote_Job_Number);
	attributes.put("revision_number",jobRec.Quote_Revision_Number.toString());
	attributes.put("job_reference",jobRec.Job_Reference.toString());
	attributes.put("job_stage",jobRec.Job_Stage.Full_Stage_Name.toString());
	attributes.put("followup_status",jobRec.FUP_Status.toString());
	attributes.put("work_site_address",jobRec.Work_Site_Address.toString());
	attributes.put("work_site_address_oneline",ifnull(jobRec.Work_Site_Address,"").toString().replaceAll("\n",", "));
	attributes.put("work_site_address_oneline_nocountry",attributes.get("work_site_address_oneline").replaceAll(", New Zealand","").replaceAll(", Australia","").replaceAll(", USA","").replaceAll(",  United Kingdom",""));
	attributes.put("site_address","");
	attributes.put("quote_comments",jobRec.QuotesComment.toString());
	attributes.put("quote_scope",jobRec.Quote_Text.toString());
	attributes.put("enquiry_date",ifnull(jobRec.Is_Enquiry_Date,"").toString("dd-MM-yyyy"));
	attributes.put("start_date",ifnull(jobRec.Est_Start_Date,"").toString("dd-MM-yyyy"));
	attributes.put("finish_date",ifnull(jobRec.Est_Finish_Date,"").toString("dd-MM-yyyy"));
	if(!isBlank(jobRec.Revised_Sent_Date))
	{
		quote_date = jobRec.Revised_Sent_Date;
	}
	else
	{
		quote_date = ifnull(jobRec.Is_Quoted_Date,jobRec.Added_Time);
	}
	attributes.put("quote_date",ifnull(quote_date,"").toString("dd-MM-yyyy"));
	attributes.put("revision_date",ifnull(jobRec.Revised_Sent_Date,"").toString("dd-MM-yyyy"));
	attributes.put("client_purchase_order",jobRec.Client_Purchase_Order.toString());
	if(!isBlank(jobRec.Quote_Terms_and_Conditions))
	{
		special_terms = List();
		for each  tag in Special_Conditions[ID in jobRec.Quote_Terms_and_Conditions] sort by Tag_Short_Code
		{
			special_terms.add(ifnull(tag.Tag_Full_Description,""));
		}
		attributes.put("special_terms",special_terms);
	}
}