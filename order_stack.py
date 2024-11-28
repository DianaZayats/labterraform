class OrderStack:
    def __init__(self):
    
        self.stack = []

    def is_empty(self):
        return len(self.stack) == 0

    def push_order(self, order):
        self.stack.append(order)
        print(f"Замовлення '{order}' додано до стеку.")

    def pop_order(self):
      
        if self.is_empty():
            print("Стек пустий. Немає замовлень для видалення.")
            raise IndexError("Стек порожній.")
        else:
            order = self.stack.pop()
            print(f"Замовлення '{order}' видалено зі стеку.")
            return order

    def peek_order(self):
       
        if self.is_empty():
            print("Стек пустий. Немає замовлень для перегляду.")
            return None
        else:
            return self.stack[-1]

    def size(self):
       
        return len(self.stack)

# Приклад використання:
if __name__ == "__main__":
    orders = OrderStack()

    orders.push_order("Замовлення 1")
    orders.push_order("Замовлення 2")
    orders.push_order("Замовлення 3")
   
    print(f"Останнє замовлення: {orders.peek_order()}")

   
    print(f"Кількість замовлень: {orders.size()}")

    if orders.is_empty():
        print("Стек порожній.")
    else:
        print("Стек не порожній.")
