<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Restaurants;
use Validator;


class RestaurantsController extends Controller
{
    function getRestaurants() {
    	$restaurants = Restaurants::all();
    	return response()->json($restaurants, 200);
    }

    function createRestaurant(Request $request) {

        $validator =  Validator::make($request->all(),[
            'name' => 'required',
            'description' => 'required',
            'grade' => 'required',
            'localization' => 'required',
            'phone_number' => 'required',
            'website' => 'required',
            'hours' => 'required',
        ]);

        if($validator->fails()){
            return response()->json(["error" => 'The request was invalid.',
            "message" => $validator->errors(),], 400);
        }

        try {
            $restaurant = Restaurants::create($request->all());
            return response()->json(["message" => "restaurant created successfully"], 201);
        }
        catch(Exception $e){
            return response()->json(["error" => "Unable to register user"], 400);
        }
    }
    
    function deleteRestaurant($id) {
        if(Restaurants::where('id', $id)->exists()) {
        	$restaurant = Restaurants::find($id);
        	$restaurant->delete();

        	return response()->json(["message" => "records deleted successfully"], 200);
      	} else {
        	return response()->json(["error" => "The request was invalid."], 400);
      	}
    }

    function updateRestaurant(Request $request, $id) {
    	if (Restaurants::where('id', $id)->exists()) {
        	$restaurant = Restaurants::find($id);
        	$restaurant->update($request->all());

        	return response()->json([ "message" => "record updated successfully"], 200);
        } else {
        	return response()->json(["error" => "The request was invalid."], 400);  
    	}

    }
}
