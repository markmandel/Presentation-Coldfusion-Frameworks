<cfimport taglib="/customtags/forms/cfUniForm" prefix="uform">
<html>
	<head>
		<title>TO-DO Application - Basic</title>

		<link rel="stylesheet" type="text/css" href="/assets/default.css" />
	</head>
	<body>

		<uform:form action="#cgi.script_name#"
			id="todo"
			submitValue="Add Todo"
			loadjQuery="true"
			loadValidation="true"
			loadMaskUI="true"
			loadDateUI="true"
			loadTimeUI="true"
			loadRatingUI="true"
			loadTextareaResize="true"
			commonassetsPath="/assets/cfuniform/">

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
	</body>
</html>
