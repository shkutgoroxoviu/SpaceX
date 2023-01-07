//
//  NetworkService.swift
//  SpaceX
//
//  Created by Гурген Хоршикян on 30.08.2022.
//

import Foundation

class NetworkService {
    func loadSpaceshipsInfo(complition: @escaping ([Spaceship]) -> Void) {
        let urlString = "https://api.spacexdata.com/v4/rockets"
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _ , error in
            guard let data = data else {
                print(String(describing: error?.localizedDescription))
                return
            }
            
            guard let model = self.parseJson(type: [Spaceship].self, data: data) else {
                return
            }
            
            complition(model)
        }.resume()
    }
    
    func parseJson<T: Codable>(type: T.Type, data: Data) -> T? {
        let decoder = JSONDecoder()
        let model = try? decoder.decode(T.self, from: data)
        return model
    }
    
    func loadLaunchInfo(complition: @escaping ([Launch]) -> Void ) {
        let urlString = "https://api.spacexdata.com/v4/launches"
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                print(String(describing: error?.localizedDescription))
                return
            }
            
            guard let model = self.parseJson(type: [Launch].self, data: data) else {
                return
            }
            
            complition(model)
        }.resume()
    }
    

    
}
