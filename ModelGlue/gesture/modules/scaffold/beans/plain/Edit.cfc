<!---
LICENSE INFORMATION:

Copyright 2011, Joe Rinehart, Dan Wilson

Licensed under the Apache License, Version 2.0 (the "License"); you may not 
use this file except in compliance with the License. 

You may obtain a copy of the License at 

	http://www.apache.org/licenses/LICENSE-2.0 
	
Unless required by applicable law or agreed to in writing, software distributed
under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR 
CONDITIONS OF ANY KIND, either express or implied. See the License for the 
specific language governing permissions and limitations under the License.

VERSION INFORMATION:

This file is part of Model-Glue 'Gesture' 3.2 RC1 (3.2.439).

The version number in parentheses is in the format versionNumber.subversion.revisionNumber.

If the version number appears as 'versionNumber' surrounded by @ symbols
then this file is a working copy and not part of a release build.
--->


<cfcomponent extends="ModelGlue.gesture.modules.scaffold.beans.AbstractScaffold" output="false" hint="I am used whever type=""edit"" is used in a scaffold tag.">

<cffunction name="makeModelGlueXMLFragment" output="false" access="public" returntype="string" hint="I make an instance of a modelglue xml fragment for this event">
	<cfargument name="advice" type="struct" required="true"/>
	<cfargument name="alias" type="string" required="true"/>
	<cfargument name="class" type="string" required="true"/>
	<cfargument name="eventtype" type="string" required="true"/>
	<cfargument name="orderedpropertylist" type="string" required="true"/>
	<cfargument name="prefix" type="string" required="true"/>
	<cfargument name="primarykeylist" type="string" required="true"/>
	<cfargument name="properties" type="struct" required="true"/>
	<cfargument name="propertylist" type="string" required="true"/>
	<cfargument name="suffix" type="string" required="true"/>
	
	<cfset var relationshipMessages = "" />
	<cfset var thisProp = "" />
	<cfset var knownRelationships = "" />
	<cfset var xml = "" />
	
	<cfloop collection="#arguments.properties#" item="thisProp">
		<cfif arguments.properties[thisProp].relationship IS true AND listfind( knownRelationships, thisProp ) IS false>
			<cfset relationshipMessages = '#relationshipMessages#
				<message name="ModelGlue.genericList">
					<argument name="object" value="#arguments.properties[thisProp].sourceObject#" />
					<argument name="queryName" value="#arguments.properties[thisProp].sourceObject#List" />
					<argument name="criteria" value="" />
				</message>'>
		<cfset knownRelationships = listAppend(knownRelationships, thisProp) />
		</cfif>
	</cfloop>
	
	<cfset xml = '
		<event-handler name="#arguments.alias#.Edit" access="public"' />
	
	<cfif len(arguments.eventtype)>
		<cfset xml = xml & ' type="#arguments.eventtype#"' />
	</cfif>
	
	<cfset xml = xml & '>
			<broadcasts>
				<message name="ModelGlue.genericRead">
					<argument name="criteria" value="#arguments.primaryKeyList#" />
					<argument name="object" value="#arguments.alias#" />
					<argument name="recordName" value="#arguments.alias#Record" />
				</message>#relationshipMessages#
			</broadcasts>
			<views>
				<view name="body" template="#arguments.prefix##arguments.alias##arguments.suffix#" append="true">
					<value name="xe.commit" value="#arguments.alias#.Commit" overwrite="true" />
					<value name="xe.list" value="#arguments.alias#.List" overwrite="true" />
				</view>
			</views>
			<results>
			</results>
		</event-handler>
'>
	
	<cfreturn xml />
</cffunction>	

</cfcomponent>
