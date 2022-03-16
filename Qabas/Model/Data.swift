//
//  Data.swift
//  Qabas
//
//  Created by Razan bin rashed on 10/08/1443 AH.
//


import Foundation

protocol DataDelegate : class{
    
    func handelAddCategory()
}
class Data {
    
    static var delegate : DataDelegate?
static var quoteList = [
    CateList(CateName: "Scenice", NumberOfQuote: 19),
    CateList(CateName: "Design", NumberOfQuote: 17),
    CateList(CateName: "Psychological", NumberOfQuote: 9),
    CateList(CateName: "Historical Fiction ", NumberOfQuote: 13)
]
{
    didSet{
        delegate?.handelAddCategory()

    }
}



}
