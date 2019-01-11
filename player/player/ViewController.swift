import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController,UIScrollViewDelegate,AVAudioPlayerDelegate {
    var imageView:UIImageView!
    var scrollView:UIScrollView!
    var Player:AVAudioPlayer?
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imageView = UIImageView(frame: self.view.bounds)
        imageView.image = UIImage(named: "picture1.jpeg")
        imageView.isUserInteractionEnabled = true
        scrollView = UIScrollView(frame: self.view.frame)
        scrollView.backgroundColor = UIColor.black
        scrollView.contentSize = imageView.bounds.size
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        let Button = UIButton()
        Button.setTitle("Play", for: UIControlState.normal)
        Button.frame = CGRect(x: 50, y: 1150, width: 200, height: 150)
        self.view.addSubview(Button)
        let PauseButton = UIButton()
        PauseButton.setTitle("Pause", for: UIControlState.normal)
        PauseButton.frame = CGRect(x: 50, y: 350, width: 200, height: 150)
        self.view.addSubview(PauseButton)
        PauseButton.addTarget(self, action: #selector(pause), for: UIControlEvents.touchUpInside)
        let pageButton = UIButton()
        pageButton.setTitle("next page", for: UIControlState.normal)
        pageButton.frame = CGRect(x: 50, y: 350, width: 200, height: 150)
        pageButton.addTarget(self, action: #selector(page), for: UIControlEvents.touchUpInside)
        self.view.addSubview(pageButton)
        UIApplication.shared.beginReceivingRemoteControlEvents()
        rescoure()
    }
    @objc func page(){
        imageView = UIImageView(frame: self.view.bounds)
        imageView.image = UIImage(named: "picture2.jpeg")
        imageView.isUserInteractionEnabled = true
        scrollView = UIScrollView(frame: self.view.frame)
        scrollView.backgroundColor = UIColor.black
        scrollView.contentSize = imageView.bounds.size
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        let Button = UIButton()
        Button.setTitle("vedio", for: UIControlState.normal)
        Button.frame = CGRect(x: 50, y: 250, width: 200, height: 150)
        Button.addTarget(self, action: #selector(Video), for: UIControlEvents.touchUpInside)
        self.view.addSubview(Button)
        let backButton = UIButton()
        backButton.setTitle("back", for: UIControlState.normal)
        backButton.frame = CGRect(x: 50, y: 450, width: 200, height: 150)
        Button.addTarget(self, action: #selector(viewDidLoad), for: UIControlEvents.touchUpInside)
        self.view.addSubview(backButton)
        
    }
    @objc func Video() {
        let photoUrl = "Desktop/player/river.mp4"
        let playerViewController = AVPlayerViewController()
        playerViewController.player = photoUrl
        self.present(playerViewController, animated: true) {}
    }
    @objc func play() {
        Player?.play()
    }
    @objc func pause() {
        Player?.pause()
    }
    func rescoure() {
        let musicPath = Bundle.main .path(forResource: "咏叹调", ofType: "mp3")
        let musicUrl = URL(fileURLWithPath: musicPath!)
        do {
            Player = try AVAudioPlayer(contentsOf: musicUrl)
        }
        catch {
            Player = nil
        }
    }
    override func remoteControlReceived(with event: UIEvent?) {
        switch event!.subtype {
        case .remoteControlPlay:
            Player?.play()
        case .remoteControlPause:
            Player?.pause()
        case .remoteControlStop:
            Player?.stop()
        default:
            break
        }
        do {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
    }
}
