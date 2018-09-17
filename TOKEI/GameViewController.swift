//
//  GameViewController.swift
//  TOKEI
//
//  Created by ただひろ on 2018/09/16.
//  Copyright © 2018年 Goemon. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {
    var fmtH: DateFormatter!
    var fmtM: DateFormatter!
    var fmtS: DateFormatter!
    var scene: SCNScene!
    var hariH: SCNNode!
    var hariM: SCNNode!
    var tim: Timer!
    
    func makeTextH() -> SCNNode {
        let n = 12
        let node = SCNNode()
        for i in 0 ..< n {
            let text = SCNNode(geometry: SCNBox(width: 0.3, height: 0.1, length: 0.1, chamferRadius: 0))
            text.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
            let t = CGFloat.pi * 2 / CGFloat(n) * CGFloat(i)
            let x = cos(t) * 3
            let y = sin(t) * 3
            text.position = SCNVector3(x, y, 0)
            text.rotation = SCNVector4(0, 0, 1, t)
            node.addChildNode(text)
        }
        return node
    }

    func makeTextM() -> SCNNode {
        let n = 60
        let node = SCNNode()
        for i in 0 ..< n {
            let text = SCNNode(geometry: SCNBox(width: 0.3, height: 0.1, length: 0.1, chamferRadius: 0))
            text.geometry?.firstMaterial?.diffuse.contents = UIColor.white
            let t = CGFloat.pi * 2 / CGFloat(n) * CGFloat(i)
            let x = cos(t) * 3
            let y = sin(t) * 3
            text.position = SCNVector3(x, y, 0)
            text.rotation = SCNVector4(0, 0, 1, t)
            node.addChildNode(text)
        }
        return node
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a new scene
        scene = SCNScene(named: "art.scnassets/tokei.scn")!
        let nodeTextM = makeTextM()
        let nodeTextH = makeTextH()
        
        nodeTextM.position = SCNVector3(0, 0, 0)
        nodeTextH.position = SCNVector3(0, 0, 0.5)
        scene.rootNode.addChildNode(nodeTextM)
        scene.rootNode.addChildNode(nodeTextH)

        // retrieve the SCNView
        let scnView = self.view as! SCNView
        
        // set the scene to the view
        scnView.scene = scene
        
        // allows the user to manipulate the camera
        scnView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        scnView.showsStatistics = true
        
        // configure the view
        scnView.backgroundColor = UIColor.black
        
        fmtH = DateFormatter()
        fmtM = DateFormatter()
        fmtS = DateFormatter()
        fmtH.dateFormat = "HH"
        fmtM.dateFormat = "mm"
        fmtS.dateFormat = "ss"
        
        hariM = scene.rootNode.childNode(withName: "HARI-L", recursively: true)
        hariH = scene.rootNode.childNode(withName: "HARI-S", recursively: true)

        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {
            _ in
            let t = Date()
            let strH = self.fmtH.string(from: t)
            let strM = self.fmtM.string(from: t)
            let strS = self.fmtS.string(from: t)
            let h = Int(strH)!
            let m = Int(strM)!
            let s = Int(strS)!
            self.hariH.rotation = SCNVector4(0, 0, 1, CGFloat.pi * 2 /  720 * -CGFloat(h * 60 + m))
            self.hariM.rotation = SCNVector4(0, 0, 1, CGFloat.pi * 2 / 3600 * -CGFloat(m * 60 + s))
       })
    }
}
