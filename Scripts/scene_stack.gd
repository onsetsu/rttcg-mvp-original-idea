extends Node

var stack = []

func call_if_exists(object, method):
    if object.has_method(method):
        funcref(object, method).call_func()

func init(scene):
    stack = [scene]
    call_if_exists(scene, "ss_init")

func push(scene):
    var last_top_scene = top()
    stack.push_back(scene)
    call_if_exists(last_top_scene, "ss_suspend")
    call_if_exists(scene, "ss_init")
    
func pop():
    var last_top_scene = stack.pop_back()
    call_if_exists(last_top_scene, "ss_end")
    call_if_exists(top(), "ss_resume")

# directly switch scenes without calling the scene beneath
func switch_to(scene):
    var last_top_scene = stack.pop_back()
    call_if_exists(last_top_scene, "ss_end")
    stack.push_back(scene)
    call_if_exists(scene, "ss_init")

func top():
    return stack[-1]
