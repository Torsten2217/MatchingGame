//
//  Game.swift
//  MatchingGame
//
//  Created by Mac on 14-10-20.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

import Foundation
import UIKit
var score:NSMutableArray=NSMutableArray()
class GameSceneViewController: UIViewController {
    var blankTileImage:UIImage=UIImage(named: "back.png")!
    var backTileImage:UIImage=UIImage(named: "blank.png")!
    
    var tiles:NSMutableArray=NSMutableArray(objects:
        UIImage(named: "icons01.png")!,
        UIImage(named: "icons01.png")!,
        UIImage(named: "icons02.png")!,
        UIImage(named: "icons02.png")!,
        UIImage(named: "icons03.png")!,
        UIImage(named: "icons03.png")!,
        UIImage(named: "icons04.png")!,
        UIImage(named: "icons04.png")!,
        UIImage(named: "icons05.png")!,
        UIImage(named: "icons05.png")!,
        UIImage(named: "icons06.png")!,
        UIImage(named: "icons06.png")!,
        UIImage(named: "icons07.png")!,
        UIImage(named: "icons07.png")!,
        UIImage(named: "icons08.png")!,
        UIImage(named: "icons08.png")!,
        UIImage(named: "icons09.png")!,
        UIImage(named: "icons09.png")!,
        UIImage(named: "icons10.png")!,
        UIImage(named: "icons10.png")!,
        UIImage(named: "icons11.png")!,
        UIImage(named: "icons11.png")!,
        UIImage(named: "icons12.png")!,
        UIImage(named: "icons12.png")!,
        UIImage(named: "icons13.png")!,
        UIImage(named: "icons13.png")!,
        UIImage(named: "icons14.png")!,
        UIImage(named: "icons14.png")!,
        UIImage(named: "icons15.png")!,
        UIImage(named: "icons15.png")!)
    @IBOutlet weak var gameScoreLabel: UILabel!
    var shuffledTiles:NSMutableArray=NSMutableArray()
    var matchCounter:NSInteger=0
    var guessCounter:NSInteger=0
    var tileFlipped:NSInteger=0
    var tile1:UIButton=UIButton()
    var tile2:UIButton=UIButton()
    var isDisabled=false
    var isMatch=false

    
    @IBAction func tileClicked(sender: AnyObject) {
        if(isDisabled==true){
            return
        }
        var senderID:Int=sender.tag;
        if(self.tileFlipped>=0&&senderID != self.tileFlipped){
            self.tile2=sender as! UIButton
            var lastImage:UIImage=self.tiles.objectAtIndex(self.tileFlipped) as! UIImage
            var tileImage:UIImage=self.tiles.objectAtIndex(senderID) as! UIImage
            
            sender.setImage(tileImage, forState: UIControlState.Normal)
            self.guessCounter++
            if(tileImage==lastImage){
                self.tile1.enabled=false
                self.tile2.enabled=false
                self.matchCounter++
                isMatch=true
            }
            isDisabled=true
            NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("resetTiles"), userInfo: nil, repeats: false)
            self.tileFlipped = -1
        }else{
            self.tileFlipped=senderID
            
            self.tile1=sender as! UIButton
            
            var tileImage:UIImage=self.tiles.objectAtIndex(senderID) as! UIImage
            
            sender.setImage(tileImage, forState: UIControlState.Normal)
            
        }
        gameScoreLabel.text="Matches: \(self.matchCounter),Guesses: \(self.guessCounter)"
    }

    func resetTiles(){
        
        if(isMatch){
            
            self.tile1.setImage(self.backTileImage, forState: UIControlState.Normal)
            self.tile2.setImage(self.backTileImage, forState: UIControlState.Normal)
        }else{
            
            self.tile1.setImage(self.blankTileImage, forState: UIControlState.Normal)
            self.tile2.setImage(self.blankTileImage, forState: UIControlState.Normal)
            
        }
        
        isDisabled=false
        isMatch=false
        if(self.matchCounter==(self.tiles.count/2)){
            self.winner()
        }

    }
    func winner(){
        self.gameScoreLabel.text="You won with \(self.guessCounter) Guesses";
        
        var alert=UIAlertView(title: "游戏已完成",message: "是否保存猜测数字",delegate:self ,cancelButtonTitle: "否")
        alert.addButtonWithTitle("是")
        alert.show()

        
    }
    
    func alertView(_alertView: UIAlertView,
        clickedButtonAtIndex buttonIndex: Int){
            var name:NSString=_alertView.buttonTitleAtIndex(buttonIndex)
            if(name.isEqualToString("是")){
                score.addObject(self.gameScoreLabel.text!)

            }
            
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameScoreLabel.text="Matches: \(self.matchCounter),Guesses: \(self.guessCounter)"
        self.shuffleTiles()
        
        
    }
    
    func shuffleTiles(){
        var tileCount:Int=tiles.count
        var tileID:Int=0
        for(tileID;tileID<(tileCount/2);tileID++){
            self.shuffledTiles.addObject(NSNumber(int: Int32(tileID)))
            self.shuffledTiles.addObject(NSNumber(int: Int32(tileID)))
        }
        var i:NSInteger=0
        
        for(i;i < tileCount;++i){
            var nElements:NSInteger = tileCount - i
            
            var a=arc4random()
            var b=a%UInt32(nElements)
            var n=b + UInt32(i)
            self.shuffledTiles.exchangeObjectAtIndex(Int(i), withObjectAtIndex: Int(n))
            self.tiles.exchangeObjectAtIndex(Int(i), withObjectAtIndex: Int(n))
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}