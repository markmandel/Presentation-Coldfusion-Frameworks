import model.*;

component extends="MachII.mach-ii"
{
	this.name = "Todo Application - MacII";
	this.datasource = "frameworks";

	/**
     * Application start method
     */
    public boolean function onApplicationStart()
    {
		var gateway = new TodoGateway();

		application.service = new TodoService(gateway);

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
    		location("/");
    		return false;
    	}

    	super.onRequestStart(arguments.targetPage);

    	return true;
    }
}