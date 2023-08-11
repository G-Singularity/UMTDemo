//
//  BeerModel.swift
//  BeersListDemo
//
//  Created by dqh on 8/8/23.
//

import Foundation

struct BeerModel: Codable {
    
    // base
    var image_url: String?
    var target_og: Float?
    var food_pairing: [String]?
    var attenuation_level: Float?
    var volume: Volume?
    var brewers_tips: String?
    //var ingredients: Ingredients?
    var tagline: String?
    var srm: Float?
    var target_fg: Int64?
    var mothod: Method?
    var name: String?
    var abv: Float?
    var ph: Float?
    var boil_volume: Volume?
    var ebc: Float?
    var id: Int?
    var contributed_by: String?
    var ibu: Float?
    var first_brewed: String?
    var description: String?
    // local
    //var isFav: Bool? = false
}

struct Ingredients: Codable {
    var yeast: String?
    var malt: [Malt]?
    var hops: [Hops]?
}

struct Malt: Codable {
    var name: String?
    var amount: Volume?
}

struct Hops: Codable {
    var name: String?
    var amount: Volume?
    var add: String?
    var attribute: String?
}

struct Method: Codable {
    var mash_temp: [MashTemp]?
    var twist: String?
    var fermentation: Fermentation?
}

struct MashTemp: Codable {
    var temp: Volume?
    var duration: Int?
}

struct Fermentation: Codable {
    var temp: Volume?
}

//MARK: - u struct
struct Volume: Codable {
    var value: Int?
    var unit: String?
}
