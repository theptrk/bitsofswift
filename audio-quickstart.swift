// [ ] Add to the Info.plist: Privacy – Microphone Usage Description
"The audio recorded by this app is stored securely and is not shared."

// [ ] import AVFoundation and add the binary
import AVFoundation

// [ ] get the AVAudioSession singleton instance
foo = AVAudioSession.sharedInstance()

// [ ] configure the AVAudioSession
try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)

// [ ] activate the AVAudioSession
try recordingSession.setActive(true)

// [ ] request the recording permission
recordingSession.requestRecordPermission() { [unowned self] allowed in ... }

// [ ] based on permission callback, use main thread to toggle recording UI
DispatchQueue.main.async {
    if allowed {
        self.foo()
    } else {
        // failed to record!
    }
}

// [ ] create a function that gets the users documents directory
func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectory = paths[0]
    return documentsDirectory
}

// [ ] get a filename path string by appending a filename to the users documents directory
let audioFilename = getDocumentsDirectory().appendingPathComponent("foo.m4a")

// [ ] create a settings object for AVAudioRecorder
let settings = [
    AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
    AVSampleRateKey: 12000,
    AVNumberOfChannelsKey: 1,
    AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
]

// [ ] create an AVAudioRecorder and pass in the Settings object
audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)

// [ ] set the delegate
audioRecorder.delegate = self

// [ ] record
audioRecorder.record()

// sources:
// https://www.hackingwithswift.com/example-code/media/how-to-record-audio-using-avaudiorecorder