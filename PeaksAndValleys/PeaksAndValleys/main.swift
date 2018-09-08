//
//  main.swift
//  PeaksAndValleys
//
//  Created by Adela Toderici on 2018-09-07.
//  Copyright © 2018 Adela Toderici. All rights reserved.
//

import Foundation

print("Hello, World!")

let keyboardInput = readLine()

// To add input: click on console and add numbers as: 1, 2, 3, 4
// Please use comma and space when you add numbers in input

if let input = keyboardInput {
    
    let A = input.components(separatedBy: ", ")
    dump(A)
    
    // result is 1 because we build on the start value of array
    var result = 1
    for i in 1...A.count - 2 {
        if ((A[i - 1] < A[i] && A[i + 1] < A[i]) ||
            (A[i - 1]) > A[i] && A[i + 1] > A[i]) {
            result += 1
        }
    }
    result += 1
    
    print("Result with start and end of array considered peak or valley: ")
    print(result)
    print("Result without start and end of array: ")
    result = (result - 2 < 0) ? 0 : result - 2
    print(result)
}


