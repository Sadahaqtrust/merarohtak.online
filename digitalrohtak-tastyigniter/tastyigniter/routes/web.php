<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Config;

/*
|--------------------------------------------------------------------------
| Web Routes - Subdomain Mapping
|--------------------------------------------------------------------------
*/

Route::group(['domain' => '{restaurant}.food.digitalrohtak.online'], function () {
    
    Route::get('/', function ($restaurant) {
        // This is where you will eventually tell TastyIgniter 
        // to load a specific Location ID.
        // For now, it will just show which restaurant was requested.
        return "Welcome to " . ucfirst($restaurant) . " on the DigitalRohtak Network!";
    });

});

// Keep the default route below for the main domain
Route::get('/', function () {
    return view('welcome');
});
