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
			Color.gray.edgesIgnoringSafeArea(.all) //底层灰色
			//to unlock scene
			Circle()
				.fill(RadialGradient(gradient: colors, center: .center, startRadius: 40, endRadius: 50))//渐变填充
				.opacity(isLocked ? 0 : 1)
				.scaleEffect(isLocked ? 0 : 9)
				.animation(.easeOut(duration: 1.5))
			VStack {
				
				//icon
				Lock(isLocked: self.isLocked, baseSize: 100)
				
				//interface
				Button("Open") {
					withAnimation(.easeOut(duration: 3)) {
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
