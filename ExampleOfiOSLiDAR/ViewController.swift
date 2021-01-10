//
//  ViewController.swift
//  ExampleOfiOSLiDAR
//
//  Created by TokyoYoshida on 2021/01/07.
//

import RealityKit
import ARKit

class ViewController: UIViewController, ARSessionDelegate {
    
    @IBOutlet var arView: ARView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arView.session.delegate = self

        
        // Add the box anchor to the scene

        arView.environment.sceneUnderstanding.options = []
        arView.environment.sceneUnderstanding.options.insert(.occlusion)
        arView.environment.sceneUnderstanding.options.insert(.physics)
        arView.debugOptions.insert(.showSceneUnderstanding)
        arView.renderOptions = [.disablePersonOcclusion, .disableDepthOfField, .disableMotionBlur]
        arView.automaticallyConfigureSession = false

        let configuration = ARWorldTrackingConfiguration()
        configuration.sceneReconstruction = .meshWithClassification

        configuration.environmentTexturing = .automatic
        arView.session.run(configuration)

        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        arView.addGestureRecognizer(tapRecognizer)

        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
        arView.scene.anchors.append(boxAnchor)
    }

    @objc
    func handleTap(_ sender: UITapGestureRecognizer) {
        func sphere(radius: Float, color: UIColor) -> ModelEntity {
            let sphere = ModelEntity(mesh: .generateSphere(radius: radius), materials: [SimpleMaterial(color: color, isMetallic: false)])
            // Move sphere up by half its diameter so that it does not intersect with the mesh
            sphere.position.y = radius
            return sphere
        }
        let tapLocation = sender.location(in: arView)
        if let result = arView.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .any).first {
            let resultAnchor = AnchorEntity(world: result.worldTransform)
            resultAnchor.addChild(sphere(radius: 0.1, color: .lightGray))
            arView.scene.addAnchor(resultAnchor)
        }
    }
}
