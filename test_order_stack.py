import unittest
from order_stack import OrderStack  

class TestOrderStack(unittest.TestCase):
    def setUp(self):
    
        self.orders = OrderStack()

    def test_push_order(self):
      
        self.orders.push_order("Замовлення 1")
        self.assertEqual(self.orders.size(), 1)

    def test_pop_order(self):
     
        self.orders.push_order("Замовлення 1")
        self.orders.push_order("Замовлення 2")
        order = self.orders.pop_order()
        self.assertEqual(order, "Замовлення 2")  
        self.assertEqual(self.orders.size(), 1)

    def test_peek_order(self):
       
        self.orders.push_order("Замовлення 1")
        order = self.orders.peek_order()
        self.assertEqual(order, "Замовлення 1") 
        self.assertEqual(self.orders.size(), 1)  
    def test_is_empty(self):
     
        self.assertTrue(self.orders.is_empty())

    def test_pop_empty_stack(self):
        with self.assertRaises(IndexError):  
            self.orders.pop_order()

    def test_negative_scenario_pop_empty(self):
        with self.assertRaises(IndexError):  
            self.orders.pop_order()
        with self.assertRaises(IndexError): 
            self.orders.pop_order()

if __name__ == '__main__':
    unittest.main()
