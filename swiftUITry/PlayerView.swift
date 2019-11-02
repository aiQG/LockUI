//
//  PlayerView.swift
//  SwiftUI2UIKit
//
//  Created by 周测 on 11/2/19.
//  Copyright © 2019 aiQG_. All rights reserved.
//

import Foundation
import SwiftUI
import AVFoundation


class PlayerUIView: UIView {
	
	private let playerLayer = AVCaptureVideoPreviewLayer()
	var layerSession = AVCaptureSession()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		layerSession.sessionPreset = AVCaptureSession.Preset.photo
		let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
		
		//Set I/O
		let deviceInput = try! AVCaptureDeviceInput(device: captureDevice!)
		let deviceOutput = AVCaptureVideoDataOutput()
		deviceOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)]
		deviceOutput.setSampleBufferDelegate(self, queue: DispatchQueue.global(qos: DispatchQoS.QoSClass.default))//这里处理
		layerSession.addInput(deviceInput)
		layerSession.addOutput(deviceOutput)
		
		playerLayer.session = layerSession
		layer.addSublayer(playerLayer)
		layerSession.startRunning()
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	override func layoutSubviews() {
		super.layoutSubviews()
		//Set size
		playerLayer.frame = bounds
	}
}

struct PlayerView: UIViewRepresentable {
	//UIKit初始化?
	func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) {
	}
	//包装UIKit为SwiftUI为可用的东西///返回的还是UIView
	func makeUIView(context: Context) -> UIView {
		return PlayerUIView(frame: .zero)
	}
}





extension PlayerUIView: AVCaptureVideoDataOutputSampleBufferDelegate {
	
	func captureOutput(_ output: AVCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
		
	}//Drop data
	
	func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
		
	}//Get data
	
}
