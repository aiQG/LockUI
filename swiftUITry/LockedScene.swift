//
//  LockedScene.swift
//  swiftUITry
//
//  Created by 周测 on 10/28/19.
//  Copyright © 2019 aiQG_. All rights reserved.
//

import SwiftUI


struct LockedScene: View {
	@State var isLocked: Bool = false
	@EnvironmentObject var envPView: PlayerUIView
	
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
				ZStack {
					Circle()
						.fill(RadialGradient(gradient: colors, center: .center, startRadius: 80, endRadius: 90))//渐变填充
						.opacity(!envPView.unlock ? 0 : 1)
						.scaleEffect(!envPView.unlock ? 0 : 9)
						.animation(.easeOut(duration: 1.5))
					
					PlayerView(pView: envPView)
						.frame(width: 200)
						.clipShape(Circle())
						.overlay(Circle().stroke(Color.gray, lineWidth: 4))
						.shadow(radius: 10)
				}
				
				Lock(isLocked: !envPView.unlock, baseSize: 50)
					.position(CGPoint(x: UIScreen.main.bounds.width * 0.5, y: 100))
					.animation(.easeOut(duration: 1))
				
				Button("Lock") {
					self.envPView.unlock = false
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
