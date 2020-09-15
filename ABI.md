## What is ABI?

https://stackoverflow.com/questions/2171177/what-is-an-application-binary-interface-abi

One easy way to understand "ABI" is to compare it to "API".

You are already familiar with the concept of an API. If you want to use the features of, say, some library or your OS, you will use an API. The API consists of data types/structures, constants, functions, etc that you can use in your code to access the functionality of that external component.

An ABI is very similar. Think of it as the compiled version of an API (or as an API on the machine-language level). When you write source code, you access the library though an API. Once the code is compiled, your application accesses the binary data in the library through the ABI. The ABI defines the structures and methods that your compiled application will use to access the external library (just like the API did), only on a lower level.

ABIs are important when it comes to applications that use external libraries. If a program is built to use a particular library and that library is later updated, you don't want to have to re-compile that application (and from the end-user's standpoint, you may not have the source). If the updated library uses the same ABI, then your program will not need to change. The interface to the library (which is all your program really cares about) is the same even though the internal workings may have changed. Two versions of a library that have the same ABI are sometimes called "binary-compatible" since they have the same low-level interface (you should be able to replace the old version with the new one and not have any major problems).

Sometimes, ABI changes are unavoidable. When this happens, any programs that use that library will not work unless they are re-compiled to use the new version of the library. If the ABI changes but the API does not, then the old and new library versions are sometimes called "source compatible". This implies that while a program compiled for one library version will not work with the other, source code written for one will work for the other if re-compiled.

https://www.reddit.com/r/swift/comments/67z7dy/what_is_abi_stability_and_why_does_it_matter/

Today, the latest version of Swift is 3.1, so chances are if you ship an app tomorrow, your app bundle will contain the Swift dynamic libraries for 3.1, however, there are plenty of apps in the store right now which link 3.0, 2.3, and probably even some older apps that link 2.1 and earlier. Nothing is stopping me from downloading your app (on 3.1) and my app (on 2.3) and running them side-by-side on my iPhone with iOS 10.3, since both apps link against their own bundled version of Swift. It's exactly the same as you bundling Alamofire 4.4 and while I bundle 3.0.

When a language is ABI-stable (Application Binary Interface), that means it is packaged and linked with the operating system itself, in this case: iOS. The Swift code you compile on your computer has a binary interface into the operating system itself rather than any dynamic library you bundle with your application. Because of this, Apple has to be able to guarantee that my Swift code, when compiled to machine code (bitcode, LLVM-IR, yada-yada), will be able to interface properly with the rest of the operating system, and (probably more importantly) will not break between versions of iOS / Swift.

As it stands today, the Swift language specification and compiler are not in a state where the Swift team would feel comfortable making this promise of ABI-stability; changes to Swift are still too frequent and the roadmap is still too long. As soon as the Swift library is merged into iOS, it becomes much much harder to make big changes.
Why does it matter?

Yes, the bundle size of your application will decrease because you will no longer have to include the Swift standard library in your Frameworks folder, which is nice.
Language changes will be smaller / less frequent, so you won't have to worry about events like migration from Swift 2 -> 3 (I'm still scarred from that)

Developers will be able to create 3rd-party libraries written in Swift and distribute pre-compiled frameworks (binaries), because they no longer need to bundle the Swift standard library into their framework, and will instead be linking against the same version of Swift as your app (the one packaged with iOS).
