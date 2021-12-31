//
//  ErrorAPI.swift
//  BankinChallenge
//
//  Created by Alexandre Legros on 22/12/2021.
//

import Foundation

enum ErrorAPI: String, Error {
    case errorCallAPI = "Une erreure s'est produit lors de la récupération des données"
    case jsonDecodeErrorListOfBank = "Erreur lors du décodage de la liste des banques"
    case noneData = "Aucune donnée n'a été retournée"
    case errorHTTP = "Une erreur réseau s'est produite"
}
