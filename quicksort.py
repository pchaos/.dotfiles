def quicksort(arr):
    if len(arr) <= 1:
        return arr
    pivot = arr[len(arr) // 2]
    left = [x for x in arr if x < pivot]
    middle = [x for x in arr if x == pivot]
    right = [x for x in arr if x > pivot]
    return quicksort(left) + middle + quicksort(right)

# 示例用法
if __name__ == "__main__":
    example_array = [3, 6, 8, 10, 1, 2, 1]
    print("原始数组:", example_array)
    sorted_array = quicksort(example_array)
    print("排序后的数组:", sorted_array)
