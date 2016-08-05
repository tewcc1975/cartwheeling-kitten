//
//  Album.swift
//  HelloWorld
//
//  Created by Transcend on 8/13/14.
//  Copyright (c) 2014 SunLoveSystems. All rights reserved.
//

import Foundation

class Album {
    var title: String
    var price: String
    var thumbnailImageURL: String
    var largeImageURL: String
    var itemURL: String
    var artistURL: String
    var collectionId: Int
    
    init(name: String, price: String, thumbnailImageURL: String, largeImageURL: String, itemURL: String, artistURL: String, collectionId: Int) {
        self.title = name;
        self.price = price;
        self.thumbnailImageURL = thumbnailImageURL
        self.largeImageURL = largeImageURL
        self.itemURL = itemURL
        self.artistURL = artistURL
        self.collectionId = collectionId
    }
    
    class func albumsWithJSON(allResults: NSArray) -> [Album] {
        // Create an empty array of albums to append to from this list
        var albums = [Album]()
        
        // Store the results in our table data array
        if allResults.count>0 {
            
            // Sometimes iTunes returns a collection, not a track, so check both
            for result in allResults {
                var name = result["trackName"] as? String
                if name == nil {
                    name = result["collectionName"] as? String
                }
                
                // Sometimes price comes in as formattedPrice, sometimes as collectionPrice
                var price = result["formattedPrice"] as? String
                if price == nil {
                    price = result["collectionPrice"] as? String
                    if price == nil {
                        var priceFloat: Float? = result["collectionPrice"] as? Float
                        var nf: NSNumberFormatter = NSNumberFormatter()
                        nf.maximumFractionDigits = 2;
                        if priceFloat != nil {
                            price = "$"+nf.stringFromNumber(priceFloat)
                        }
                    }
                }
                
                let thumbnailURL = result["artworkUrl60"] as? String
                let imageURL = result["artworkUrl100"] as? String
                var artistURL = result["artistViewUrl"] as? String
                if artistURL == nil {
                    artistURL = "*"
                }
                
                var itemURL = result["collectionViewUrl"] as? String
                if itemURL == nil {
                    itemURL = result["trackViewUrl"] as? String
                }
                
                var collectionId = result["collectionId"] as? Int
                
                var newAlbum = Album(name: name!, price: price!, thumbnailImageURL: thumbnailURL!, largeImageURL: imageURL!, itemURL: itemURL!, artistURL: artistURL!, collectionId: collectionId!)
                albums.append(newAlbum)
            }
        }
        return albums
    }
}