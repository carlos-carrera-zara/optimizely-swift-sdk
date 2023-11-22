//
// Copyright 2019, 2021, Optimizely, Inc. and contributors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import XCTest

@testable import Optimizely

class iOSOnlyTests: XCTestCase {

    var subject = AtomicProperty<Int>(property: 1)
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func test_atomicPropertyDeadlocks() async {
        let operationQueue = OperationQueue()
        let expectations = (0..<80).map { id in
            let expectation = expectation(description: "Queue Test \(id)")
            operationQueue.addOperation {
                self.subject.property = (self.subject.property ?? 0) + 1
                Thread.sleep(forTimeInterval: 0.1)
                self.subject.property = (self.subject.property ?? 0) + 1
                expectation.fulfill()
            }
            return expectation
        }

        let finalExpectation = expectation(description: "Final")
        operationQueue.addBarrierBlock {
            finalExpectation.fulfill()
        }

        await fulfillment(of: expectations + CollectionOfOne(finalExpectation), timeout: 10.0)

        self.subject.property = 0
    }

}
