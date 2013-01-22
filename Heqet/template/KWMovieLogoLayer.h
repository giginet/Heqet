//
//  KWMovieLogoLayer.h
//  MultipleSession
//
//  Created by giginet on 2013/1/23.
//
//

#import "KWLogoLayer.h"
#import "CCVideoPlayer.h"

/*
 Kawazサウンドロゴを組み込んだロゴテンプレートです
 別途、cocos2d-extentionsのCCVideoPlayerの導入が必要です。
 */
@interface KWMovieLogoLayer : KWLogoLayer <CCVideoPlayerDelegate> {
  CCVideoPlayer* _player;
}

@end
