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
import Vision


class PlayerUIView: UIView {
	
	var requests = [VNRequest]()
	
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
		
		let faceRequest = VNDetectFaceRectanglesRequest(completionHandler: self.detectFaceHandler(request:error:))
		self.requests = [faceRequest]
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	override func layoutSubviews() {
		super.layoutSubviews()
		//Set size
		playerLayer.frame = bounds
	}
	
	func detectFaceHandler(request: VNRequest, error: Error?) {
		guard let faceDetectionRequest = request as? VNDetectFaceRectanglesRequest,
			let results = faceDetectionRequest.results as? [VNFaceObservation] else {
				return
		}
		if results.count > 0{
			print("face!")
		}
		
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
		//print("get it")
		guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
			return
		}
		
		var requestOptions:[VNImageOption: Any] = [:]
		
		if let camData = CMGetAttachment(sampleBuffer,key: kCMSampleBufferAttachmentKey_CameraIntrinsicMatrix, attachmentModeOut: nil){
			requestOptions = [VNImageOption.cameraIntrinsics: camData]
		}
		
		let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: CGImagePropertyOrientation(rawValue: 8)!, options: requestOptions)
		
		do{
			try imageRequestHandler.perform(self.requests)
		} catch {
			print(error)
		}
	}//Get data
	
}
