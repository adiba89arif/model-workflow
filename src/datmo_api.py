from flask import Flask, request, jsonify
app = Flask(__name__)
from inspect import getmembers, isfunction
import user_api_functions

functions_list = [o for o in getmembers(user_api_functions) if isfunction(o[1])]

@app.route('/<func_name>', methods=['POST'])
def api_root(func_name):
    for function in functions_list:
        if function[0] == func_name:
            try:
                json_req_data = request.get_json()
                if json_req_data:
                    res = function[1](json_req_data)
            except Exception as e:
                return {"error": "Please check function signatures and/or input"}
            return jsonify({"result": res})
    return 'Welcome'

if __name__ == '__main__':
    app.run(host='0.0.0.0')

