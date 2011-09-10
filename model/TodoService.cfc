<cfcomponent hint="service layer for todo" accessors="true">

<!------------------------------------------- PUBLIC ------------------------------------------->

<cfproperty name="gateway" type="TodoGateway">

<cffunction name="init" hint="Constructor" access="public" returntype="TodoService" output="false">
	<cfargument name="gateway" hint="the todo gateway" type="TodoGateway" required="Yes">
	<cfscript>
		setGateway(arguments.gateway);

		return this;
	</cfscript>
</cffunction>

<cffunction name="saveTodo" hint="save a todo object" access="public" returntype="void" output="false">
	<cfargument name="todo" hint="the todo object" type="Todo" required="Yes">
	<cfset getGateway().saveTodo(arguments.todo)>
</cffunction>

<cffunction name="listTodos" hint="list all todos" access="public" returntype="array" output="false">
	<cfreturn getGateway().listTodos() />
</cffunction>

<cffunction name="getTodo" hint="get an individual todo" access="public" returntype="Todo" output="false">
	<cfargument name="id" hint="the todo id" type="numeric" required="Yes">
	<cfreturn getGateway().getTodo(arguments.id) />
</cffunction>

<cffunction name="deleteTodo" hint="delete a todo object" access="public" returntype="void" output="false">
	<cfargument name="todo" hint="the todo object" type="Todo" required="Yes">
	<cfset getGateway().deleteTodo(arguments.todo)>
</cffunction>

<!------------------------------------------- PACKAGE ------------------------------------------->

<!------------------------------------------- PRIVATE ------------------------------------------->

</cfcomponent>