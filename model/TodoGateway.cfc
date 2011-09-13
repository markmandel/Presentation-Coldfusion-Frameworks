<cfcomponent hint="Gateway access for todo's" output="false">

<!------------------------------------------- PUBLIC ------------------------------------------->

<cffunction name="init" hint="Constructor" access="public" returntype="TodoGateway" output="false">
	<cfscript>
		return this;
	</cfscript>
</cffunction>

<cffunction name="saveTodo" hint="save a todo object" access="public" returntype="void" output="false">
	<cfargument name="todo" hint="the todo object" type="Todo" required="Yes">
	<cfset entitySave(arguments.todo)>
</cffunction>

<cffunction name="getTodo" hint="get an individual todo" access="public" returntype="Todo" output="false">
	<cfargument name="id" hint="the todo id" type="numeric" required="Yes">
	<cfreturn entityLoadByPK("Todo", arguments.id) />
</cffunction>

<cffunction name="listTodos" hint="list all todos" access="public" returntype="array" output="false">
	<cfreturn entityload("Todo") />
</cffunction>

<cffunction name="deleteTodo" hint="delete a todo object" access="public" returntype="void" output="false">
	<cfargument name="todo" hint="the todo object" type="Todo" required="Yes">
	<cfset entityDelete(arguments.todo)>
</cffunction>

<!------------------------------------------- PACKAGE ------------------------------------------->

<!------------------------------------------- PRIVATE ------------------------------------------->

</cfcomponent>