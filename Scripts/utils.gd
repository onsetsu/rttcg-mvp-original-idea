extends Node

func get_nodes_in_groups(groups):
    var cards_in_first_group = get_tree().get_nodes_in_group(groups[0])
    var first = true
    for g in groups:
        if first:
            first = false
        else:
            var new_group = []
            for c in cards_in_first_group:
                if c.is_in_group (g):
                    new_group.append(c)
            cards_in_first_group = new_group
    return cards_in_first_group

func node_exists(node):
    if node == null:
      return false

    var ref = weakref(node).get_ref()

    if ref == null:
      return false

    if ref.is_queued_for_deletion():
      return false

    return true
# array utils
# ---------------------------------------------------------------------------------------------

func shuffle(list):
    var shuffledList = [] + list

    for i in range(list.size() - 1, 0, -1):
        randomize()
        var x = randi()%i
        
        # swap
        var temp = shuffledList[x]
        shuffledList[x] = shuffledList[i]
        shuffledList[i] = temp

    return shuffledList

func arr_copy(array):
    var result = []
    for item in array:
        result.append(item)
    return result
    
func pluck(array, prop):
    var result = []
    for item in array:
        result.append(item[prop])
    return result

func filter_props(array, props):
    var result = []
    for item in array:
        var should_append = true
        for key in props:
            if props[key] != item[key]:
                should_append = false
        if should_append:
            result.append(item)
    return result

func filter_prop(array, prop, value):
    var result = []
    for item in array:
        if item[prop] == value:
            result.append(item)
    return result
    
func filter_func(array, prop, value):
    var result = []
    for item in array:
        if funcref(item, prop).call_func() == value:
            result.append(item)
    return result

func max(list):
    var ret
    for val in list:
        if not ret:
            ret = val
        else:
            if val > ret:
                ret = val
    return ret

func min(list):
    var ret
    for val in list:
        if not ret:
            ret = val
        else:
            if val < ret:
                ret = val
    return ret