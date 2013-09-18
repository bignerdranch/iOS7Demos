//
//  BNRViewController.m
//  SpeechSynthDemo
//
//  Created by Jonathan Blocksom on 9/2/13.
//  Copyright (c) 2013 Jonathan Blocksom. All rights reserved.
//

#import "BNRViewController.h"

@import AVFoundation;

@interface BNRViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textToSpeak;
@property (weak, nonatomic) IBOutlet UISlider *speedSlider;

@property (strong, nonatomic) AVSpeechSynthesizer *synthesizer;

@end

@implementation BNRViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.synthesizer = [[AVSpeechSynthesizer alloc] init];
    
    self.speedSlider.minimumValue = AVSpeechUtteranceMinimumSpeechRate;
    self.speedSlider.maximumValue = AVSpeechUtteranceMaximumSpeechRate;
    self.speedSlider.value = AVSpeechUtteranceDefaultSpeechRate;
}

- (IBAction)sayIt:(id)sender {
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:self.textToSpeak.text];
    utterance.rate = self.speedSlider.value;
    [self.synthesizer speakUtterance:utterance];

    // Change the voice locality (move this to before speaking):
//    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"fr-CA"];  // French Canadian

}

@end
