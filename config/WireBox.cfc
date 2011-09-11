<cfcomponent output="false" hint="The default WireBox Injector configuration object" extends="coldbox.system.ioc.config.Binder">
<cfscript>

	/**
	* Configure WireBox, that's it!
	*/
	function configure()
	{
		map("todoService")
			.to("model.TodoService")
			.asSingleton()
			.initArg(name="gateway", ref="todoGateway");
		map("todoGateway")
			.to("model.TodoGateway")
			.asSingleton();
	}
</cfscript>
</cfcomponent>