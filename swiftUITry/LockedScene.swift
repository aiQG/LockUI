//
//  LockedScene.swift
//  swiftUITry
//
//  Created by 周测 on 10/28/19.
//  Copyright © 2019 aiQG_. All rights reserved.
//

import SwiftUI


struct LockedScene: View {
	@State var isLocked: Bool = true
	let colors = Gradient(
		colors: [.green,
				 .init(Color.RGBColorSpace.sRGB,
					   red: 0,
					   green: 1,
					   blue: 0,
					   opacity: 0)]
	)
	var body: some View {
		ZStack {
			Color.gray.edgesIgnoringSafeArea(.all)
			VStack {
				//Camera
				ZStack {
					//to unlock scene
					Circle()
						.fill(RadialGradient(gradient: colors, center: .center, startRadius: 80, endRadius: 90))//渐变填充
						.opacity(isLocked ? 0 : 1)
						.scaleEffect(isLocked ? 0 : 9)
						.animation(.easeOut(duration: 1.5))
					PlayerView()
						.frame(width: 200)
						.clipShape(Circle())
						.overlay(Circle().stroke(Color.gray, lineWidth: 4))
						.shadow(radius: 10)
				}
				
				//Icon
				Lock(isLocked: self.isLocked, baseSize: 50)
					.position(CGPoint(x: UIScreen.main.bounds.width * 0.5,
									  y: 100))
				//interface
				Button("Open") {
					withAnimation(.easeOut(duration: 1)) {
						self.isLocked.toggle()
					}
				}
			}
		}
	}
}

struct LockedScene_Previews: PreviewProvider {
	static var previews: some View {
		LockedScene()
	}
}
