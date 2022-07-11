//
//  IViewModel.swift
//  Airports
//
//  Created by Dawid Karpiński on 06/07/2022.
//

protocol IViewModel {
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
}
