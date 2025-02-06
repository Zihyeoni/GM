# person.py

class Person:
	def __init__(self, name, age):
		self.name = name
		self.age = age

	def greet(self):
		print(f"안녕하세요, 제 이름은 {self.name}이고 나이는 {self.age}입니다.")