/**
 * I am a Todo!
 */
component accessors="true"
{
	/**
     *  Primary Key
     */
	property name="id" type="numeric";

	/**
     * The title of the todo.
     */
	property name="title" type="string";

	/**
     * todo description
     */
	property name="description" type="string";

	/**
     * completion date
     */
	property name="completionDate" type="date";

	/**
     * important level
     */
	property name="importance" type="numeric";

	/**
     * Constructor
     */
    public Todo function init()
    {
    	return this;
    }

    /**
     * set the state of this object
     */
    public void function setMemento(required struct memento)
    {
    	if(structKeyExists(arguments.memento, "id"))
    	{
	    	setID(arguments.memento.id);
    	}

    	setTitle(arguments.memento.title);
    	setDescription(arguments.memento.description);

		if(structKeyExists(arguments.memento, "completionDate") && Len(arguments.memento.completionDate))
		{
			setCompletionDate(arguments.memento.completionDate);
		}

		if(structKeyExists(arguments.memento, "importance") && Len(arguments.memento.importance))
		{
			setImportance(arguments.memento.importance);
		}
    }

	/**
     * is this todo overdue?
     */
    public boolean function isOverdue()
    {
    	if(isNull(getCompletionDate()))
    	{
    		return false;
    	}

    	if(dateCompare(Now(), getCompletionDate()) == 1)
		{
			return true;
		}

		return false;
    }
}