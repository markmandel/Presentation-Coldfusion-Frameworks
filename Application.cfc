import model.*;
import coldspring.beans.xml.XmlBeanFactory;

component
{
	this.name = "Todo Application - Basic";
	this.datasource = "frameworks";

	/**
     * Application start method
     */
    public boolean function onApplicationStart()
    {
		application.coldspring = new XmlBeanFactory(expandPath("/config/coldspring.xml"));

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