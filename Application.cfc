import model.*;

component extends="org.corfield.framework"
{
	this.name = "Todo Application - FW/1";
	this.datasource = "frameworks";

	variables.framework = {
		// default section name:
		defaultSection = 'todo',
		// default item name:
		defaultItem = 'index'
	};

	/**
     * Application start method
     */
    public boolean function onApplicationStart()
    {
		var gateway = new TodoGateway();

		application.service = new TodoService(gateway);

    	super.onApplicationStart();

    	return true;
    }

	/**
     * request start function
     */
    public boolean function onRequestStart(required string targetPath)
    {
    	if(structKeyExists(url, "reload"))
    	{
    		applicationStop();
    		location("/");
    		return false;
    	}

    	super.onRequestStart(arguments.targetPath);

    	return true;
    }
}