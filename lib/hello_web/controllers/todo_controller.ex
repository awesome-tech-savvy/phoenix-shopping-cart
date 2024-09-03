defmodule HelloWeb.TodoController do
  use HelloWeb, :controller

  alias Hello.Todos
  alias Hello.Todos.Todo

  def index(conn, _params) do
    todos = Todos.list_todos()
    changeset = Todos.change_todo(%Todo{})
    render(conn, :index, todos: todos, changeset: changeset)
  end

  def create(conn, %{"todo" => todo_params}) do
    case Todos.create_todo(todo_params) do
      {:ok, _todo} ->
        conn
        |> put_flash(:info, "Todo created successfully.")
        |> redirect(to: ~p"/todos")

      # {:error, %Ecto.Changeset{} = changeset} ->
      #   render(conn, :new, changeset: changeset)
      {:error, changeset} ->
        todos = Todos.list_todos()
        conn
        |> put_flash(:error, "There was an error creating your todo.")
        |> render("index.html", todos: todos, changeset: changeset)
    end
  end

  # def show(conn, %{"id" => id}) do
  #   product =
  #     id
  #     |> Catalog.get_product!()
  #     |> Catalog.inc_page_views()

  #   render(conn, :show, product: product)
  # end

  # def edit(conn, %{"id" => id}) do
  #   product = Catalog.get_product!(id)
  #   changeset = Catalog.change_product(product)
  #   render(conn, :edit, product: product, changeset: changeset)
  # end

  # def update(conn, %{"id" => id, "product" => product_params}) do
  #   product = Catalog.get_product!(id)

  #   case Catalog.update_product(product, product_params) do
  #     {:ok, product} ->
  #       conn
  #       |> put_flash(:info, "Product updated successfully.")
  #       |> redirect(to: ~p"/products/#{product}")

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, :edit, product: product, changeset: changeset)
  #   end
  # end

  def delete(conn, %{"id" => id}) do
    todo = Todos.get_todo!(id)

    case Todos.delete_todo(todo) do
      {:ok, _todo} ->
        conn
        |> put_flash(:info, "Todo deleted successfully.")
        |> redirect(to: ~p"/todos")

      {:error, _reason} ->
        conn
        |> put_flash(:error, "There was an error deleting your todo.")
        |> redirect(to: ~p"/todos")
    end
  end
end
