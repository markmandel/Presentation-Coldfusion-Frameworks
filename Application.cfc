import model.*;

component extends="coldbox.system.Coldbox"
{
	this.name = "Todo Application - ColdBox - ColdSpring - ORM";
	this.datasource = "frameworks";
	this.sessionManagement = true;

	//COLDBOX STATIC PROPERTY, DO NOT CHANGE UNLESS THIS IS NOT THE ROOT OF YOUR COLDBOX APP
	COLDBOX_APP_ROOT_PATH = getDirectoryFromPath(getCurrentTemplatePath());
	//The web server mapping to this application. Used for remote purposes or static purposes
	COLDBOX_APP_MAPPING   = "";
	//COLDBOX PROPERTIES
	COLDBOX_CONFIG_FILE   = "";
	//COLDBOX APPLICATION KEY OVERRIDE
	COLDBOX_APP_KEY       = "";

	//enable orm, and set it up
	this.ormEnabled = true;
	this.ormSettings.autoManageSession = false;
	this.ormSettings.cfclocation = "model";
	this.ormSettings.flushatrequestend = false;
	this.ormSettings.useDBForMapping = false;

	/**
     * Application start method
     */
    public boolean function onApplicationStart()
    {
		return super.onApplicationStart();
    }

	/**
     * request start function
     */
    public boolean function onRequestStart(required string targetPage)
    {
    	if(structKeyExists(url, "reload"))
    	{
    		applicationStop();
    		location("/", false);
    		return false;
    	}

    	return super.onRequestStart(arguments.targetPage);
    }
}