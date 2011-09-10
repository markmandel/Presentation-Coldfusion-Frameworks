component
{
	this.name = "Todo Application - Basic";
	this.datasource = "frameworks";

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