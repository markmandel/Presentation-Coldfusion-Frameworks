import model.*;

/**
 * Handler/Controller for todo items
 */
component accessors="true"
{
	property name="todoService";
	property name="framework";

	/**
     * Constructor
     */
    public Todo function init(required any framework)
    {
    	setTodoService(application.service);
    	setFramework(arguments.framework);
    	return this;
    }

	/**
     * Index page, lists all todos
     */
    public void function index(required any rc)
    {
    	arguments.rc.list = getTodoService().listTodos();
    }

    /**
     * Add a todo
     */
    public void function add(required any rc)
    {
		var todo = new model.Todo();
		todo.setMemento(arguments.rc);

		getTodoService().saveTodo(todo);

		getFramework().redirect("todo.index");
    }

    /**
     * delete a todo
     */
    public void function delete(required any rc)
    {
    	param name="arguments.rc.delete_id" default="";
		var ids = ListToArray(arguments.rc.delete_id);
    	for(var id in ids)
    	{
    		var todo = getTodoService().getTodo(id);
    		getTodoService().deleteTodo(todo);
    	}

    	getFramework().redirect("todo.index");
    }
}