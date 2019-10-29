//
//  Lock.swift
//  swiftUITry
//
//  Created by 周测 on 10/29/19.
//  Copyright © 2019 aiQG_. All rights reserved.
//

import SwiftUI

struct Lock: View {
	@State var baseLength: CGFloat = 100
	@State var toUp: CGFloat = 0 //0 ~ baseLength*0.1857 ///first
	@State var toRight: CGFloat = -0.6 //-0.6 ~ 0.6 ///second
	var body: some View {
		
		VStack {
			RoundedRectangle(cornerRadius: baseLength / 5)
				.frame(width: baseLength,
					   height: baseLength - baseLength / 10)
				.overlay(
					Path { path in
						
						path.move(to: CGPoint(x: baseLength * 0.8,
											  y: baseLength / 2.5 - toUp))
						
						path.addLine(to: CGPoint(x: baseLength * 0.8,
												 y: -baseLength / 10 - toUp))
						
						path.addCurve(
							to: CGPoint(
								x: baseLength * (0.8 + toRight),
								y: -baseLength / 10 - toUp),
							control1: CGPoint(
								x: baseLength * 0.8 ,
								y: -baseLength * 0.382 / 0.618 + 10 - toUp),
							control2: CGPoint(
								x: baseLength * (0.8 + toRight),
								y: -baseLength * 0.382 / 0.618 + 10 - toUp))
						
						path.addLine(to: CGPoint(x: baseLength * (0.8 + toRight),
												 y: baseLength * 0.1 - toUp))
						
					}
					.stroke(Color.black, lineWidth: baseLength / 10)
					.animation(.easeInOut(duration: 3))
			)
				.foregroundColor(.red)
			
			
			Button("BUTTON"){
				withAnimation(.easeInOut(duration: 4)){
					self.toUp = self.baseLength*0.1857
				}
			} //利用三目运算
			
			
			
			
		}
	}
	
}


struct Lock_Previews: PreviewProvider {
	static var previews: some View {
		Lock(baseLength: 100.0, toUp: 0, toRight: -0.6)
		//.previewLayout(.sizeThatFits)
	}
}
