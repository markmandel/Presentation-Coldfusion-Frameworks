import model.*;

/**
 * Handler/Controller for todo items
 */
component accessors="true"
{
	property name="todoService" inject="ioc:todoService";

	/**
     * Constructor
     */
    public Todo function init()
    {
    	return this;
    }

	/**
     * Index page, lists all todos
     */
    public void function index(required any event)
    {
    	var rc = arguments.event.getCollection();

    	rc.list = getTodoService().listTodos();
    }

    /**
     * Add a todo
     */
    public void function add(required any event)
    {
		var todo = new model.Todo();
		todo.setMemento(arguments.event.getCollection());

		getTodoService().saveTodo(todo);

		setNextEvent("todo.index");
    }

    /**
     * delete a todo
     */
    public void function delete(required any event)
    {
		var ids = arguments.event.getValue("delete_id", "");
		ids = ListToArray(ids);
    	for(var id in ids)
    	{
    		var todo = getTodoService().getTodo(id);
    		getTodoService().deleteTodo(todo);
    	}

    	setNextEvent("todo.index");
    }
}