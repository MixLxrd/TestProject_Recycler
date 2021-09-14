import Foundation

class NetworkDataFetcher {
    
    let networkService = NetworkService()
    
    func fetchAreas(response: @escaping (Areas?) -> Void) {
        networkService.request(urlString: "https://api.hh.ru/areas") { (result) in
            switch result {
            case .success(let data):
                do {
                    let tracks = try JSONDecoder().decode(Areas.self, from: data)
                    response(tracks)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    response(nil)
                }
            case .failure(let error):
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
        }
    }
}
