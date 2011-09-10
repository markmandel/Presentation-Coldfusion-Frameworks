/**
 * Controller for todo events
 */
component extends="ModelGlue.gesture.controller.Controller" accessors="true"
{
	property name="todoService";

	import model.*;

	/**
     * Constructor
     */
    public TodoController function init()
    {
		super.init();

		//in the real world, you would use ColdSpring, but we're demoing without for now.
		setTodoService(application.service);

    	return this;
    }

	/**
     * list all todos
     */
    public void function listTodos(required any event)
    {
		var list = getTodoService().listTodos();
    	arguments.event.setValue("list", list);
    }

	/**
     * save a todo from the event data
     */
    public void function saveTodo(required any event)
    {
		todo = new Todo();
		todo.setMemento(arguments.event.getAllValues());

		getTodoService().saveTodo(todo);
    }

    /**
     * delete a todo
     */
    public void function deleteTodo(required any event)
    {
		var ids = arguments.event.getValue("delete_id", "");
		ids = ListToArray(ids);
    	for(var id in ids)
    	{
    		todo = getTodoService().getTodo(id);
    		getTodoService().deleteTodo(todo);
    	}
    }
}