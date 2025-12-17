<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class UserController extends Controller
{
    // Register new user
    public function register(Request $request)
    {
        // Validate Flutter inputs
        $validatedData = $request->validate([
            'first_name' => 'required|string|max:255',
            'last_name'  => 'required|string|max:255',
            'phone'      => 'required|string|max:20|unique:users',
            'birth_date' => 'required|date',
            'image'      => 'required|image|mimes:jpg,jpeg,png',
            'id_image'   => 'required|image|mimes:jpg,jpeg,png',
        ]);

        // Store personal image
        if ($request->hasFile('image')) {
            $validatedData['image'] = $request->file('image')->store('users/profiles','public');
        }

        // Store ID image
        if ($request->hasFile('id_image')) {
            $validatedData['id_image'] = $request->file('id_image')->store('users/identities','public');
        }

        // Assign a default password (since Flutter is not sending one)
        $validatedData['password'] = Hash::make('defaultpassword');

        $user = User::create($validatedData);

        // Return user info including image URLs
        return response()->json([
            'success' => true,
            'message' => 'User Registered Successfully',
            'user' => [
                'id' => $user->id,
                'first_name' => $user->first_name,
                'last_name' => $user->last_name,
                'phone' => $user->phone,
                'birth_date' => $user->birth_date,
                'image_url' => $user->image_url,
                'id_image_url' => $user->id_image_url,
            ],
        ], 201);
    }

    // Login user (username + phone)
    public function login(Request $request)
    {
        $request->validate([
            'username' => 'required|string',
            'phone'    => 'required|string',
        ]);

        $user = User::where('first_name', $request->username)
                    ->where('phone', $request->phone)
                    ->first();

        if (!$user) {
            return response()->json([
                'success' => false,
                'message' => 'Wrong username or phone'
            ], 401);
        }

        // Create token if using Sanctum
        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'success' => true,
            'message' => 'Login Successfully',
            'user'    => $user,
            'token'   => $token,
        ], 200);
    }

    // Logout user
    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'success' => true,
            'message' => 'Logout Successfully'
        ], 200);
    }
}
