/**
* ********************************************************************************
* Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
* www.ortussolutions.com
* ********************************************************************************
* HTTP Response model, spice up as needed and stored in the request scope
*/
component accessors="true"{

	property name="format" 			type="string" 		default="json";
	property name="data" 			type="any"			default="";
	property name="error" 			type="boolean"		default="false";
	property name="binary" 			type="boolean"		default="false";
	property name="messages" 		type="array";
	property name="location" 		type="string"		default="";
	property name="jsonCallback" 	type="string"		default="";
	property name="jsonQueryFormat" type="string"		default="true" hint="JSON Only: This parameter can be a Boolean value that specifies how to serialize ColdFusion queries or a string with possible values row, column, or struct";
	property name="contentType" 	type="string"		default="";
	property name="statusCode" 		type="numeric"		default="200";
	property name="statusText" 		type="string"		default="OK";
	property name="responsetime"	type="numeric"		default="0";
	property name="cachedResponse" 	type="boolean"		default="false";
	property name="headers" 		type="array";

	/**
	* Constructor
	*/
	Response function init(){
		// Init properties
		variables.format 			= "json";
		variables.data 				= {};
		variables.error 			= false;
		variables.binary 			= false;
		variables.messages 			= [];
		variables.location 			= "";
		variables.jsonCallBack 		= "";
		variables.jsonQueryFormat 	= "query";
		variables.contentType 		= "";
		variables.statusCode 		= 200;
		variables.statusText 		=  "OK";
		variables.responsetime		= 0;
		variables.cachedResponse 	= false;
		variables.headers 			= [];

		return this;
	}

	/**
	* Add some messages
	* @message Array or string of message to incorporate
	*/
	function addMessage( required any message ){
		if( isSimpleValue( arguments.message ) ){ arguments.message = [ arguments.message ]; }
		variables.messages.addAll( arguments.message );
		return this;
	}

	/**
	* Add a header
	* @name The header name ( e.g. "Content-Type" )
	* @value The header value ( e.g. "application/json" )
	*/
	function addHeader( required string name, required string value ){
		arrayAppend( variables.headers, { name=arguments.name, value=arguments.value } );
		return this;
	}

	/**
	* Returns a standard response formatted data packet
	* @reset Reset the 'data' element of the original data packet
	*/
	function getDataPacket( boolean reset=false ) {
		var packet = {
			"error" 		 = variables.error ? true : false,
			"messages" 		 = variables.messages,
			"data" 			 = variables.data
		};

		// Are we reseting the data packet
		if( arguments.reset ){
			packet.data = {};
		}

		return packet;
	}
}