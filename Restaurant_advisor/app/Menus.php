<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Menus extends Model
{
    protected $table = 'menus';

    protected $fillable = ['name', 'description', 'price', 'Restaurant_id'];

    public function restaurant()
    {
     	return $this->belongsTo(Restuarants::class); 
    }
}
