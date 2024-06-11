import Foundation
import SwiftUI
import ARKit

struct ARView: UIViewRepresentable {
    func makeUIView(context: Context) -> ARSCNView {
        let arView = ARSCNView()
        arView.delegate = context.coordinator
        let scene = SCNScene()
        arView.scene = scene
        let compassNode = createCompassNode()
        scene.rootNode.addChildNode(compassNode)
        return arView
    }
    
    func updateUIView(_ uiView: ARSCNView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, ARSCNViewDelegate {
        func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
            // 实现罗盘的旋转逻辑，根据设备的方向来更新罗盘的姿态
            guard let frame = (renderer as? ARSCNView)?.session.currentFrame,
                  let scene = renderer.scene,
                  let compassNode = scene.rootNode.childNode(withName: "compassNode", recursively: true) else { return }
            
            compassNode.eulerAngles.y = .pi - frame.camera.eulerAngles.y
        }
    }
    
    private func createCompassNode() -> SCNNode {
        let compassNode = SCNNode()
        
        // 导入罗盘模型
        guard let compassScene = SCNScene(named: "compass.obj") else {
            fatalError("Failed to load compass model")
        }
        for childNode in compassScene.rootNode.childNodes {
            compassNode.addChildNode(childNode)
        }
        // 放置位置
        compassNode.position = SCNVector3(0, 0, -1)
        // 缩放大小
        compassNode.scale = SCNVector3(0.01, 0.01, 0.01)
        
        // 设置节点名称
        compassNode.name = "compassNode"
        
        return compassNode
    }
}
