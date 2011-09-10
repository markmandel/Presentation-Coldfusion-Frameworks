﻿<cfimport taglib="/customtags/forms/cfUniForm" prefix="uform">
<html>
	<head>
		<title>TO-DO Application - MachII</title>

		<link rel="stylesheet" type="text/css" href="/assets/default.css" />
	</head>
	<body>

		<uform:form action="#BuildUrl('addTodo')#"
			id="todo-add"
			submitValue="Add Todo"
			loadjQuery="true"
			loadValidation="true"
			loadDateUI="true"
			loadRatingUI="true"
			loadTextareaResize="true"
			commonassetsPath="/assets/cfuniform/">

			<h1>TO-DO Application - MachII</h1>

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

		<uform:form action="#buildURL('deleteTodo')#"
			id="todo-delete"
			submitValue="Delete Todo"
			commonassetsPath="/assets/cfuniform/">

			<uform:fieldset legend="Current To-Do's">
				<cfset list = event.getArg('list')>
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

					<uform:field
						name="delete_id"
						id="delete_id_#todo.getID()#"
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
