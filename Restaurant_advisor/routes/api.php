<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Users;
use App\Restaurants;
use App\Menus;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

/*Route::middleware('auth:api')->get('/user', function (Request $request) {
   return $request->user();
});*/

Route::get('/users', 'UsersController@getUsers');
Route::get('/restaurants', 'RestaurantsController@getRestaurants');
Route::post('/register', 'UsersController@register');
Route::post('/auth', 'UsersController@authenticate');
Route::post('/restaurant', 'RestaurantsController@createRestaurant');
Route::put('/restaurant/{id}', 'RestaurantsController@updateRestaurant');
Route::delete('/restaurant/{id}', 'RestaurantsController@deleteRestaurant');
Route::get('/restaurant/{id}/menus', 'MenusController@getMenu');
Route::post('/restaurant/{id}/menu', 'MenusController@createMenu');
Route::put('/restaurant/{resto_id}/menu/{menu_id}', 'MenusController@updateMenu');
Route::delete('/restaurant/{resto_id}/menu/{menu_id}', 'MenusController@deleteMenu');






