//
//  ImageLoader.swift
//  Pocket Trainer
//
//  Created by vladukha on 30.03.2021.
//

import SwiftUI
import Combine
import Foundation

class ImageLoader: ObservableObject {
	@Published var image: UIImage?
	private let url: URL
	
	init(url: URL) {
		self.url = url
	}
	
	deinit {
		cancel()
	}
	
	private var cancellable: AnyCancellable?
	
	func load() {
		withAnimation {
			cancellable = URLSession.shared.dataTaskPublisher(for: url)
				.map { UIImage(data: $0.data) }
				.replaceError(with: nil)
				.receive(on: DispatchQueue.main)
				.sink { [weak self] in self?.image = $0 }
		}
		
	}
	
	func cancel() {
		cancellable?.cancel()
	}
}

struct AsyncImage<Placeholder: View>: View {
	@StateObject private var loader: ImageLoader
	let placeholder: Placeholder

	init(url: URL, @ViewBuilder placeholder: () -> Placeholder) {
		self.placeholder = placeholder()
		_loader = StateObject(wrappedValue: ImageLoader(url: url))
	}

	var body: some View {
		content
			.onAppear(perform: loader.load)
	}

	private var content: some View {
		Group {
					if loader.image != nil {
						Image(uiImage: loader.image!)
							.resizable()
							.transition(.opacity)
							.animation(.default)
					} else {
						placeholder
					}
			
				}
	}
}
