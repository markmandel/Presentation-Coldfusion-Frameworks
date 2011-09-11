<cfcomponent output="false" hint="My App Configuration">
<cfscript>
// Configure ColdBox Application
function configure()
{

	// coldbox directives
	coldbox =
	{
		//Application Setup
		appName 				= "TODO",

		//Development Settings
		debugMode				= true,
		debugPassword			= "",
		reinitPassword			= "",
		handlersIndexAutoReload = false,
		configAutoReload		= false,

		//Implicit Events
		defaultEvent			= "todo.index",
		requestStartHandler		= "",
		requestEndHandler		= "",
		applicationStartHandler = "",
		applicationEndHandler	= "",
		sessionStartHandler 	= "",
		sessionEndHandler		= "",
		missingTemplateHandler	= "",

		//Error/Exception Handling
		exceptionHandler		= "",
		onInvalidEvent			= "",
		customErrorTemplate		= "",

		//Application Aspects
		handlerCaching 			= false,
		eventCaching			= false
	};

	//Layout Settings
	layoutSettings = {
		defaultLayout = "Layout.Main.cfm"
	};

	ioc = {
		framework="coldspring2",
		definitionFile="config/coldspring.xml"
	};

	interceptors =
	[
		//Autowire, without which, we wouldn't autowire
		{
			class="coldbox.system.interceptors.Autowire",
		 	properties={useSetterInjection=false}
		}
	];
}

</cfscript>
</cfcomponent>