<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Menus;
use App\Restaurants;
use Validator;


class MenusController extends Controller
{
    
	function getMenu($id) {
		$menu = Menus::where( [ 'Restaurant_id' => $id ] )->get();
		return response()->json($menu, 200);
	}
    
    function createMenu(Request $request, $id){
    	if(Restaurants::where('id', $id)->exists()){
            $validator =  Validator::make($request->all(),[
                'name' => 'required',
                'description' => 'required',
                'price' => 'required',
            ]);

            if($validator->fails()){
                return response()->json(["error" => 'The request was invalid.',
                "message" => $validator->errors(),], 400);
            } else 
    		  $menu = new Menus;
    		  $menu->name = $request->input('name');
    		  $menu->description = $request->input('description');
    		  $menu->price = $request->input('price');
    		  $menu->Restaurant_id = $id;
    		  $menu->save();
    		return response()->json(["message" => "menu record created"], 201);
    	} else {
    		return response()->json(["error" => "The request was invalid."], 400);
    	}
    }

    function updateMenu(Request $request, $resto_id, $menu_id) {
    	if(Restaurants::where('id', $resto_id)->exists()) {
    		if(Menus::where('id', $menu_id)->where('Restaurant_id',$resto_id)->exists()) {
        		$menu = Menus::find($menu_id);
        		$menu->update($request->all());

        		return response()->json(["message" => "records updated successfully"], 200);
        	} else {
        		return response()->json(["error" => "The request was invalid."], 400);
        	}
      	} else {
        	return response()->json(["error" => "The request was invalid."], 400);
      	}
    }

    function deleteMenu(Request $request, $resto_id, $menu_id) {
    	if(Restaurants::where('id', $resto_id)->exists()) {
    		if(Menus::where('id', $menu_id)->where('Restaurant_id',$resto_id)->exists()) {
        		$menu = Menus::find($menu_id);
        		$menu->delete();

        		return response()->json(["message" => "records deleted successfully"], 200);
        	} else {
        		return response()->json(["error" => "The request was invalid."], 400);
        	}
      	} else {
        	return response()->json(["error" => "The request was invalid."], 400);
      	}
    }

}
