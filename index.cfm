<cfif !structIsEmpty(form)>
	<cfscript>
		import model.*;

		switch(form.action)
		{
			case "create":
	    		todo = new Todo();
	    		todo.setMemento(form);

	    		application.service.saveTodo(todo);
			break;

			case "done":
				application.service.deleteTodo(todo);
			break;
		}
    </cfscript>
</cfif>

<cfscript>
	list = application.service.listTodos();
</cfscript>


<cfimport taglib="/customtags/forms/cfUniForm" prefix="uform">
<html>
	<head>
		<title>TO-DO Application - Basic</title>

		<link rel="stylesheet" type="text/css" href="/assets/default.css" />
	</head>
	<body>

		<uform:form action="#cgi.script_name#"
			id="todo-add"
			submitValue="Add Todo"
			loadjQuery="true"
			loadValidation="true"
			loadDateUI="true"
			loadRatingUI="true"
			loadTextareaResize="true"
			commonassetsPath="/assets/cfuniform/">

			<input type="hidden" name="action" value="create">

			<h1>TO-DO Application - Basic</h1>

			<uform:fieldset legend="New To-Do">
				<uform:field label="Title"
							name="title"
							isRequired="true"
							type="text"
							/>

				<uform:field label="Description"
							name="description"
							isRequired="true"
							type="textarea"
							/>

				<uform:field label="Completion Date"
							name="completionDate"
							isRequired="false"
							type="date"
							/>

				<uform:field label="Importance"
							name="importance"
							type="rating"
							/>

			</uform:fieldset>


		</uform:form>

		<br/>

		<uform:form action="#cgi.script_name#"
			id="todo-delete"
			submitValue="Delete Todo"
			commonassetsPath="/assets/cfuniform/">

			<input type="hidden" name="action" value="delete">

			<uform:fieldset legend="Current To-Do's">

				<cfloop array="#list#" index="todo">
					<cfscript>
						label = "<strong>#todo.getTitle()#</strong>";
						class = "";
						if(!isNull(todo.getCompletionDate()))
						{
							label &= ", Due: <strong>#DateFormat(todo.getCompletionDate(), 'medium')#</strong>";

							if(todo.isOverdue())
							{
								class = "overdue";
							}
						}

						if(!isNull(todo.getImportance()))
						{
							label &= " ( Importance: #todo.getImportance()# )";
						}
                    </cfscript>

					<uform:field name="delete_id"
						label="#label#"
						type="checkbox"
						value="#todo.getID()#"
						hint="#todo.getDescription()#"
						containerClass = "#class#"
						/>

				</cfloop>

			</uform:fieldset>

		</uform:form>

	</body>
</html>
