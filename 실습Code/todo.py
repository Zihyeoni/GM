# todo.py

class TodoManager:
    def __init__(self):
        self.todos = []

    def add_task(self, task):
        """할 일을 목록에 추가합니다."""
        self.todos.append(task)
        print(f"'{task}'가 할 일 목록에 추가되었습니다.")

    def remove_task(self, task):
        """할 일을 목록에서 제거합니다."""
        if task in self.todos:
            self.todos.remove(task)
            print(f"'{task}'가 할 일 목록에서 제거되었습니다.")
        else:
            print(f"'{task}'는 목록에 없습니다.")

    def show_tasks(self):
        """현재 할 일 목록을 출력합니다."""
        if not self.todos:
            print("할 일 목록이 비어 있습니다.")
        else:
            print("할 일 목록:")
            for idx, task in enumerate(self.todos, start=1):
                print(f"{idx}. {task}")