//
//  Created by Peter Combee on 21/12/2021.
//

import XCTest

class RemoteFeedLoader {
    
    private let url: URL
    private let client: HTTPClient

    init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    func load() {
        client.get(from: url)
    }
}

class HTTPClient {

    static var shared = HTTPClient()
        
    func get(from url: URL) {}

}

private class HTTPClientSpy: HTTPClient {

    override func get(from url: URL) {
        requestedURL = url
    }
    
    var requestedURL: URL?

}

final class RemoteFeedLoaderTest: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClientSpy()
        let url = URL(string: "https://a-url.com")!
        _ = RemoteFeedLoader(url: url, client: client)
         
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromURL() {
        let url = URL(string: "https://a-given-url.com")!
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)

        sut.load()
        
        XCTAssertEqual(client.requestedURL, url)
    }
}
