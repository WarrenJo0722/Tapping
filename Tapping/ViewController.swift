//
//  ViewController.swift
//  Tapping
//
//  Created by User on 12/19/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var labelSeconds: UILabel!
    
    var buttons: [UIButton] = []
    @IBOutlet weak var digit1: UIButton!
    @IBOutlet weak var digit2: UIButton!
    @IBOutlet weak var digit3: UIButton!
    @IBOutlet weak var digit4: UIButton!
    @IBOutlet weak var digit5: UIButton!
    @IBOutlet weak var digit6: UIButton!
    @IBOutlet weak var digit7: UIButton!
    @IBOutlet weak var digit8: UIButton!
    @IBOutlet weak var digit9: UIButton!
    
    @IBOutlet weak var buttonStart: UIButton!
    
    var timer: Timer?
    var seconds = 0
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buttons = [digit1, digit2, digit3, digit4, digit5, digit6, digit7, digit8, digit9]
        buttons.shuffle()
    }

    @IBAction func touchedDigit(_ sender: UIButton) {
        // 눌린 버튼의 텍스트와 현재 인덱스를 비교
        guard let buttonIndex = buttons.firstIndex(of: sender),
              buttonIndex == currentIndex else {
            return // 올바르지 않은 버튼이면 무시
        }

        // 현재 버튼 비활성화
        sender.isEnabled = false
        
        // 다음 버튼 활성화
        currentIndex += 1
        if currentIndex < buttons.count {
            buttons[currentIndex].isEnabled = true
        } else {
            // 모든 버튼이 눌렸다면 게임 종료
            timer?.invalidate()
            buttonStart.isEnabled = true
            showGameOverAlert()
        }
    }
    
    @IBAction func start(_ sender: UIButton) {
        // 타이머 시작
        timer?.invalidate() // 기존 타이머가 있으면 중단
        seconds = 0
        currentIndex = 0
        labelSeconds.text = "0s"
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        // 게임 시작 버튼 비활성화
        sender.isEnabled = false
        
        // 첫 번째 버튼 활성화
        if !buttons.isEmpty {
            buttons[currentIndex].isEnabled = true
        }
    }
    
    @objc func updateTime() {
        seconds += 1
        labelSeconds.text = "\(seconds)s"
    }
    
    func showGameOverAlert() {
        let alert = UIAlertController(title: "게임 종료!", message: "소요 시간: \(seconds)초", preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(closeAction)
        present(alert, animated: true, completion: nil)
    }
}

