from whiteboard import unique_in_order
# change whiteboard to python file name, you can change * to function name
import unittest

class UniqueInOrderTest(unittest.TestCase):

    def test_length_one(self):
        result1 = unique_in_order('A')
        self.assertEqual(result1,["A"])

    def test_uio(self):
        result = unique_in_order("AAAABBBCCDAABBB")
        self.assertEqual(result,["A", "B", "C", "D", "A", "B"] )
        
    def test_no_occurences(self):
        self.assertFalse(unique_in_order(''))

    def test_case_sensitive(self):
        result = unique_in_order("ABBCcA")
        self.assertEqual(result,["A", "B", "C", "c", "A"])

unittest.main()