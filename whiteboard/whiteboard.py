# Implement the function unique_in_order which takes as argument a sequence and returns a list of items without any elements with the same value next to each other and preserving the original order of elements.
# For example:
# unique_in_order('AAAABBBCCDAABBB') == ['A', 'B', 'C', 'D', 'A', 'B']
# unique_in_order('ABBCcAD')         == ['A', 'B', 'C', 'c', 'A', 'D']
# unique_in_order([1, 2, 2, 3, 3])   == [1, 2, 3]
# unique_in_order((1, 2, 2, 3, 3))   == [1, 2, 3]


def unique_in_order(items):
    result = []
    last_item = None
    for item in items:
        if item != last_item:
            result.append(item)
            last_item = item
    return result 

print(unique_in_order('AAAABBBCCDAABBB')) 
print(unique_in_order('ABBCcAD'))
print(unique_in_order([1, 2, 2, 3, 3]))
print(unique_in_order((1, 2, 2, 3, 3)))


def unique(items):
    return [items[i] for i in range(len(items)) if i == 0 or items[i] != items[i-1]]

print(unique('AAAABBBCCDAABBB')) 
print(unique('ABBCcAD'))
print(unique([1, 2, 2, 3, 3]))
print(unique((1, 2, 2, 3, 3)))


def uni(items):
    return [x for i, x in enumerate(items) if i == 0 or x != items[i-1]]

print(uni('AAAABBBCCDAABBB')) 
print(uni('ABBCcAD'))
print(uni([1, 2, 2, 3, 3]))
print(uni((1, 2, 2, 3, 3)))