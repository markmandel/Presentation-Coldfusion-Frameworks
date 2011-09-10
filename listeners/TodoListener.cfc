import model.*;

/**
 * Listener for Todo events
 */
component extends="MachII.framework.Listener" accessors="true"
{
	property name="todoService";

	/**
     * configure method
     */
    public void function configure()
    {
    	setTodoService(application.service);
    }

    /**
     * list all todos
     */
    public array function listTodos(required any event)
    {
    	return getTodoService().listTodos();
    }

	/**
     * save a todo from the event data
     */
    public void function saveTodo(required any event)
    {
		todo = new Todo();
		todo.setMemento(form);

		getTodoService().saveTodo(todo);
    }

    /**
     * delete a todo
     */
    public void function deleteTodo(required any event)
    {
		var ids = arguments.event.getArg("delete_id", "");
		ids = ListToArray(ids);
    	for(var id in ids)
    	{
    		todo = getTodoService().getTodo(id);
    		getTodoService().deleteTodo(todo);
    	}
    }
}