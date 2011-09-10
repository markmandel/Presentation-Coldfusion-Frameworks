import model.*;

component
{
	this.name = "Todo Application - Basic";
	this.datasource = "frameworks";

	/**
     * Application start method
     */
    public boolean function onApplicationStart()
    {
		var gateway = new TodoGateway();

		application.service = new TodoService(gateway);

    	return true;
    }

	/**
     * request start function
     */
    public boolean function onRequestStart()
    {
    	if(structKeyExists(url, "reload"))
    	{
    		applicationStop();
    		location("/");
    		return false;
    	}

    	return true;
    }
}