﻿<cfcomponent hint="Gateway access for todo's" output="false">

<!------------------------------------------- PUBLIC ------------------------------------------->

<cffunction name="init" hint="Constructor" access="public" returntype="TodoGateway" output="false">
	<cfscript>
		return this;
	</cfscript>
</cffunction>

<cffunction name="saveTodo" hint="save a todo object" access="public" returntype="void" output="false">
	<cfargument name="todo" hint="the todo object" type="Todo" required="Yes">

	<!--- we'll only do insert, as we're not allowing updates for now --->
	<cfquery name="insertTodo" result="local.insert">
		insert into todo
		(title
		 ,description
		 ,completionDate
		 ,importance)
		VALUES
		(
			<cfqueryparam value="#arguments.todo.getTitle()#" cfsqltype="cf_sql_varchar">
			,<cfqueryparam value="#arguments.todo.getDescription()#" cfsqltype="cf_sql_varchar">
			,<cfqueryparam value="#arguments.todo.getCompletionDate()#" cfsqltype="cf_sql_date" null="#isNull(arguments.todo.getCompletionDate)#">
			,<cfqueryparam value="#arguments.todo.getImportance()#" cfsqltype="cf_sql_numeric" null="#isNull(arguments.todo.getImportance())#">
		)
	</cfquery>

	<cfset arguments.todo.setID(local.insert.generatedKey)>
</cffunction>

<cffunction name="getTodo" hint="get an individual todo" access="public" returntype="Todo" output="false">
	<cfargument name="id" hint="the todo id" type="numeric" required="Yes">
	<cfquery name="local.list">
		select * from todo
		where
		id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_numeric">
		order by id
	</cfquery>
	<cfscript>
		var objectList = populateTodos(local.list);

		return objectList[1];
    </cfscript>
</cffunction>

<cffunction name="listTodos" hint="list all todos" access="public" returntype="array" output="false">
	<cfquery name="local.list">
		select * from todo
	</cfquery>
	<cfreturn populateTodos(local.list) />
</cffunction>

<cffunction name="deleteTodo" hint="delete a todo object" access="public" returntype="void" output="false">
	<cfargument name="todo" hint="the todo object" type="Todo" required="Yes">

	<!--- we'll only do insert, as we're not allowing updates for now --->
	<cfquery name="insertTodo" result="local.insert">
		delete from todo
		where
		id = <cfqueryparam value="#arguments.todo.getID()#" cfsqltype="cf_sql_numeric">
	</cfquery>
</cffunction>

<!------------------------------------------- PACKAGE ------------------------------------------->

<!------------------------------------------- PRIVATE ------------------------------------------->

<cffunction name="populateTodos" hint="get an array of todos from a query" access="public" returntype="array" output="false">
	<cfargument name="query" hint="the query of todo data" type="query" required="Yes">
	<cfscript>
		list = queryToArrayOfStructures(arguments.query);

		var objectList = [];

		for(var item in list)
		{
			var todo = new Todo();
			todo.setMemento(item);

			arrayAppend(objectList, todo);
		}

		return objectList;
    </cfscript>
</cffunction>

<cfscript>
	/**
	 * Converts a query object into an array of structures.
	 *
	 * @param query      The query to be transformed
	 * @return This function returns a structure.
	 * @author Nathan Dintenfass (nathan@changemedia.com)
	 * @version 1, September 27, 2001
	 */

	private function queryToArrayOfStructures(theQuery)
	{
		var theArray = createObject("java", "java.util.ArrayList").init(arguments.theQuery.recordCount);
		var cols = ListtoArray(theQuery.columnlist);
		var row = 1;
		var thisRow = "";
		var col = 1;
		for(row = 1; row LTE theQuery.recordcount; row = row + 1)
		{
			thisRow = structnew();
			for(col = 1; col LTE arraylen(cols); col = col + 1)
			{
				thisRow[cols[col]] = theQuery[cols[col]][row];
			}
			arrayAppend(theArray, duplicate(thisRow));
		}
		return (theArray);
	}
</cfscript>

</cfcomponent>