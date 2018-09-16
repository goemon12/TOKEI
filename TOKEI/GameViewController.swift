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
        let scene = SCNScene(named: "art.scnassets/tokei.scn")!
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
    }
}
