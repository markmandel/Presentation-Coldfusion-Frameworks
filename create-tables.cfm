<!--- create script for embedded Derby database --->
<cftry>
	<cfquery>
		drop table todo
	</cfquery>
	<cfcatch>
		<p>
			No todo table to delete.
		</p>
	</cfcatch>
</cftry>

<cfquery>
	create table todo
	(
	id INT NOT NULL GENERATED ALWAYS AS IDENTITY
	 ,title VARCHAR(1000) NOT NULL
	 ,description LONG VARCHAR NOT NULL
	 ,completionDate DATE
	 ,importance INT

	 ,PRIMARY KEY (id)
	)
</cfquery>

<p>
	Todo table created successfully.
</p>