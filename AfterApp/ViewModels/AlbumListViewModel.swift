//
//  AlbumListViewModel.swift
//  AfterApp
//
//  Created by Gorjan Ivanovski on 20.8.23.


import Combine

final class AlbumListViewModel: ObservableObject{
    @Published var albumRepository = AlbumRepository()
    @Published var albums: [Album] = []

    private var cancellables: Set<AnyCancellable> = []

    init(){
        albumRepository.$albums
            .assign(to: \.albums, on: self)
            .store(in: &cancellables)
    }

    func add (_ album: Album){
        albumRepository.add(album)
    }
}
