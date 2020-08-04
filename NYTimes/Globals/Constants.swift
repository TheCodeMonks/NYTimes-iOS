//
//  Commons.swift
//  NYTimes
//
//  Created by Waseem Akram on 31/07/20.
//  Copyright © 2020 Waseem Akram. All rights reserved.
//

import Foundation

class Constants {
    
    class Endpoints {
        static let BASEURL = "https://www.nytimes.com"
    }
    
}


class PlaceHolderData {
    
    static let articles = [
        Article(
            url: "https://www.nytimes.com/2020/07/28/science/nasa-jezero-perseverance.html",
            imageUrl: "https://static01.nyt.com/images/2020/07/28/science/28SCI-MARS-JEZERO1/28SCI-MARS-JEZERO1-jumbo.jpg",
            title: "How NASA Found the Ideal Hole on Mars to Land In",
            subtitle: "Jezero crater, the destination of the Perseverance rover, is a promising place to look for evidence of extinct Martian life.",
            author: "KENNETH CHANG"
        ),
        Article(
            url: "https://www.nytimes.com/2020/07/28/science/virgin-galactic-cabin.html",
            imageUrl: "https://static01.nyt.com/images/2020/07/28/science/28VIRGINGALACTIC2/28VIRGINGALACTIC2-videoLarge.jpg",
            title: "Virgin Galactic Unveils Comfy Cabin for Jet-Setting to the Edge of Space",
            subtitle: "Passengers able to pay hundreds of thousands of dollars for a seat can escape gravity for a few minutes.",
            author: "KENNETH CHANG"
        ),
        Article(
            url: "https://www.nytimes.com/2020/07/28/science/microbes-100-million-years-old.html",
            imageUrl: "https://static01.nyt.com/images/2020/07/28/science/28ANCIENT-MICROBES2/28ANCIENT-MICROBES2-videoLarge.jpg",
            title: "These Microbes May Have Survived 100 Million Years Beneath the Seafloor",
            subtitle: "Rescued from their cold, cramped and nutrient-poor homes, the bacteria awoke in the lab and grew.",
            author: "KATHERINE J. WU"
        )
    ]
}
