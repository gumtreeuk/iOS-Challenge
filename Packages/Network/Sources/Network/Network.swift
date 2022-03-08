import Foundation

public struct Network {
    let apiKey = "cce88709-12b4-4440-8918-dcd52cb0e949"
    public init() {
    }
    
    public func loadRequest(completion: (Result<Data, Error>) -> Void )  {
        let url = "http://content.guardianapis.com/search?q=fintech&show-fields=main,body,image&api-key=\(apiKey)"
        let request = URLRequest(url: URL(string: url)!)
        var response: AutoreleasingUnsafeMutablePointer<URLResponse?>?
        
        do {
            let data = try NSURLConnection.sendSynchronousRequest(request, returning: response)
            completion(.success(data))
        } catch(let error) {
            completion(.failure(error))
        }

    }
}
