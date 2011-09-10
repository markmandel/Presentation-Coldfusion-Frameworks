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


<cfif thisTag.executionMode eq "start"><cfexit method="exittemplate" /></cfif>
<cfimport taglib="/modelglueextensions/cfuniform/tags/forms/cfUniForm/" prefix="uform" />
<cfinclude template="../listHelperFunctions.cfm" />
<cfsilent>
	<!--- tag attributes --->
	<cfparam name="attributes.displayPropertyList" type="string" />
	<cfparam name="attributes.primaryKeyList" type="string" />
	<cfparam name="attributes.theList" type="any" />
	<cfparam name="attributes.viewEvent" type="string" />
	<cfparam name="attributes.editEvent" type="string" />
	<cfparam name="attributes.deleteEvent" type="string" />
	<cfparam name="attributes.name" type="string" />
	<cfparam name="attributes.record" type="any" default="" />
	<cfparam name="attributes.label" type="string" default="" />
	<cfparam name="attributes.parentPKList" type="string" default="" />
	<cfparam name="attributes.onEditForm" type="boolean" default="false" />
	
	<cfset isEmbedded = len(attributes.label) gt 0 /> 
	
	<cfset tableId = attributes.name & "Table" />
	
	<cfset caller.event.addCSSAssetFile( "ui/css/smoothness/jquery-ui-1.8.custom.css" ) />
	<cfset caller.event.addCSSAssetFile( "dataTables/media/css/demo_page.css" ) />
	<cfset caller.event.addCSSAssetFile( "dataTables/media/css/demo_table_jui.css" ) />
	<cfset caller.event.addCSSAssetFile( "scaffold/css/list.css" ) />
	
	<cfset caller.event.addJSAssetFile( "core/jquery-1.4.2.min.js" ) />
	<cfset caller.event.addJSAssetFile( "ui/js/jquery-ui-1.8.custom.min.js" ) />
	<cfset caller.event.addJSAssetFile( "dataTables/media/js/jquery.dataTables.min.js" ) />
	<cfset caller.event.addJSAssetFile( "scaffold/js/list.js" ) />

</cfsilent>
<cfoutput>
<cfsavecontent variable="theTable">
	<table id="#tableId#" class="dataTable">
	    <thead>
		<tr>
			 <cfloop list="#attributes.displayPropertyList#" index="thisProp">
				<th>#listLast(thisProp,"^")#</th>
			</cfloop>
			<th>&nbsp;</th>	
			<th>&nbsp;</th>	
		</tr>
	    </thead>
	    <tbody>
		<cfif isQuery(attributes.theList)>
		    <cfloop query="attributes.theList">
				<tr>	
				    <cfloop list="#attributes.displayPropertyList#"  index="thisProp">
						<cfset viewLink = attributes.viewEvent />
						<cfloop list='#attributes.primaryKeyList#' index='pk'>
							<cfset viewLink = listAppend(viewLink,"#pk#=#attributes.theList[pk][attributes.theList.currentRow]#","&") />
						</cfloop>
						#makeColumn(attributes.displayPropertyList,thisProp,viewLink,attributes.theList[listFirst(thisProp,'^')][attributes.theList.currentRow])#
					</cfloop>
    				#makeLinks(viewLink,attributes.viewEvent,attributes.editEvent,attributes.deleteEvent)#
				</tr>
			</cfloop>
		<cfelseif isStruct(attributes.theList)>
			<cfloop collection="#attributes.theList#" item="theObject">
				#makeRow(attributes.displayPropertyList,attributes.primaryKeyList,attributes.theList[theObject],attributes.viewEvent,attributes.editEvent,attributes.deleteEvent)#
			</cfloop>
		<cfelseif isArray(attributes.theList)>
			<cfloop from="1" to="#arrayLen(attributes.theList)#" index="theObject">
				#makeRow(attributes.displayPropertyList,attributes.primaryKeyList,attributes.theList[theObject],attributes.viewEvent,attributes.editEvent,attributes.deleteEvent)#
			</cfloop>
		</cfif>
	    </tbody>
	</table>
	<cfif isEmbedded>
		<cfset newLink = attributes.editEvent />
		<cfloop list='#attributes.parentPKList#' index='pk'>
			<cfset newLink = listAppend(newLink,"#pk#=#evaluate('attributes.record.get#pk#()')#","&") />
		</cfloop>
		<a href="#newLink#" class="addLink">Add to #attributes.label#</a>
	</cfif>
</cfsavecontent>

<!--- Produce output here --->
<cfif attributes.onEditForm>
	<uform:field type="custom">
		#attributes.label#
		#theTable#
	</uform:field>
<cfelse>
	<div>
		#theTable#
	</div>
</cfif>
</cfoutput>
