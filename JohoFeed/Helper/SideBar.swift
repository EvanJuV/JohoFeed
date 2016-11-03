//
//  SideBar.swift
//  SideBarControlExample
//


import UIKit


/*
Optional protocol requirements can only be specified if your protocol is marked with the @objc attribute. Even if you are not interoperating with Objective-C, you need to mark your protocols with the @objc attribute if you want to specify optional requirements.

*/

@objc protocol SideBarDelegate{
    func sideBarDidSelectMenuButtonAtIndex(index:Int)
    @objc optional func sideBarWillOpen()
    @objc optional func sideBarWillClose()
}

class SideBar: NSObject, SideBarTableViewControllerDelegate {
   
    let barWidth:CGFloat = 150.0
    let sideBarTableViewTopInset:CGFloat = 64.0
    let sideBarContainerView:UIView = UIView()
    let sideBarTableViewController:SideBarTableViewController = SideBarTableViewController()
    var animator:UIDynamicAnimator!
    var origionView:UIView!
    var delegate:SideBarDelegate?
    var isSideBarOpen:Bool = false
    
    override
    init() {
        super.init()
    }
    
    
    init(sourceView:UIView, menuItems:Array<String>){
        super.init()
        origionView = sourceView
        sideBarTableViewController.tableData = menuItems
        
         setupSideBar()
        
        animator = UIDynamicAnimator(referenceView: origionView)
        
        let showGestureRecognizer:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipe:")
        showGestureRecognizer.direction = UISwipeGestureRecognizerDirection.right
        origionView.addGestureRecognizer(showGestureRecognizer)
        
        let hideGestureRecognizer:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipe:")
        hideGestureRecognizer.direction = UISwipeGestureRecognizerDirection.left
        
        // TODO: MAYBE PLACE THAT WITHIN ORIGIN
        origionView.addGestureRecognizer(hideGestureRecognizer)
        
       
        
    }
    
    func setupSideBar(){
        sideBarContainerView.frame = CGRect(x: -barWidth-1, y: origionView.frame.origin.y, width: barWidth, height: origionView.frame.size.height)
        sideBarContainerView.backgroundColor = UIColor.clear
        sideBarContainerView.clipsToBounds = false

        
        
        origionView.addSubview(sideBarContainerView)
        
        let blurView:UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.extraLight))
        blurView.frame = sideBarContainerView.bounds
        sideBarContainerView.addSubview(blurView)
        
        
        sideBarTableViewController.delegate = self
        sideBarTableViewController.tableView.frame = sideBarContainerView.bounds
        sideBarTableViewController.tableView.clipsToBounds = false
        sideBarTableViewController.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        sideBarTableViewController.tableView.backgroundColor = UIColor.clear
        sideBarTableViewController.tableView.scrollsToTop = false
        sideBarTableViewController.tableView.contentInset = UIEdgeInsetsMake(sideBarTableViewTopInset, 0, 0, 0)
        
        sideBarTableViewController.tableView.reloadData()
        
        sideBarContainerView.addSubview(sideBarTableViewController.tableView)
        
        
    }
    
    func handleSwipe(recognizer:UISwipeGestureRecognizer){
        sideBarTableViewController.tableView.reloadData()
        if recognizer.direction == UISwipeGestureRecognizerDirection.left{
            showSideBar(shouldOpen: false)
            delegate?.sideBarWillClose?()
        }else{
            showSideBar(shouldOpen: true)
            delegate?.sideBarWillOpen?()
        }
    }
    
    func showSideBar(shouldOpen:Bool){
        animator.removeAllBehaviors()
        isSideBarOpen = shouldOpen
        
        let gravityX:CGFloat = (shouldOpen) ? 0.5 : -0.5
        let magnitude:CGFloat = (shouldOpen) ? 20 : -20
        var boundaryX:CGFloat = (shouldOpen) ? barWidth : -barWidth - 1.0
        
        let gravityBehavior:UIGravityBehavior = UIGravityBehavior(items: [sideBarContainerView])
        gravityBehavior.gravityDirection = CGVector(dx: gravityX, dy: 0)
        animator.addBehavior(gravityBehavior)
        
        
        let collisionBehavior:UICollisionBehavior = UICollisionBehavior(items: [sideBarContainerView])
        collisionBehavior.addBoundary(withIdentifier: "menuBoundary" as NSCopying, from: CGPoint(x: boundaryX, y: 20.0),
                                      to: CGPoint(x: boundaryX, y: origionView.frame.size.height))
        animator.addBehavior(collisionBehavior)

        
        let pushBehavior:UIPushBehavior = UIPushBehavior(items: [sideBarContainerView], mode: UIPushBehaviorMode.instantaneous)
        pushBehavior.magnitude = magnitude
        animator.addBehavior(pushBehavior)
        
        let sideBarBehavior:UIDynamicItemBehavior = UIDynamicItemBehavior(items: [sideBarContainerView])
        sideBarBehavior.elasticity = 0.3
        animator.addBehavior(sideBarBehavior)
        
        
    }
    
    func sideBarControllerDidSelectRow(indexPath: NSIndexPath) {
        delegate?.sideBarDidSelectMenuButtonAtIndex(index: indexPath.row)
        showSideBar(shouldOpen: false)
    }
    
}
