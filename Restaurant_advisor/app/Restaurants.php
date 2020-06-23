<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Restaurants extends Model
{
	protected $table = 'restaurants';

    protected $fillable = ['name', 'description', 'grade', 'localization', 'phone_number', 'website', 'hours'];

    public function menus()
    {
      return $this->hasMany(Menus::class);
    }
}
