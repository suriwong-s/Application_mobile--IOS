<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Validator;
use App\Users;

class UsersController extends Controller
{
    function getUsers() {
    	$users = Users::all();
    	return response()->json($users, "200");
    }

    function register(Request $request) {

    	$validator =  Validator::make($request->all(),[
            'login' => 'required | unique:users',
        	'password' => 'required',
        	'email' => 'required | unique:users',
        	'name' => 'required',
        	'firstname' => 'required',
        	'age' => 'required',
        ]);

        if($validator->fails()){
            return response()->json(["error" => 'The request was invalid.',
            "message" => $validator->errors(),], 400);
        } 

        $request->merge(['password' => bcrypt($request->password)]);

        try {
    		$user = Users::create($request->all());
    		return response()->json(["message" => "user rigistered successfully"], 201);
    	}
        catch(Exception $e){
            return response()->json(["error" => "Unable to register user"], 400);
        }

    }

    function authenticate(Request $request) {
    	$username = $request->input('login');
    	$password = $request->input('password');
 
    	if(Auth::attempt(array('login' => $username, 'password' => $password)))
        	return response()->json(["message" => "Login successfully"], 200);
        else
        	return response()->json(["error" => "The request was invalid."], 400);
    }

}
