@echo off
set /p url="Paste the path from your Homeworld Remastered data directory: "
cd ..
mklink Homeworld2.big %url%\Homeworld2.big
mklink UpdateHomeworld2.big %url%\UpdateHomeworld2.big
mklink English.big %url%\English.big
mklink EnglishSpeech.big %url%\EnglishSpeech.big
mklink UpdateHW1Ships.big %url%\UpdateHW1Ships.big
mklink UpdateHW2Ships.big %url%\UpdateHW2Ships.big
mklink HW2Ships.big %url%\HW2Ships.big
mklink HW1Ships.big %url%\HW1Ships.big
mklink HWBackgrounds.big %url%\HWBackgrounds.big
mklink Music.big %url%\Music.big
mklink MusicHW1Campaign.big %url%\MusicHW1Campaign.big
mklink MusicHW2Campaign.big %url%\MusicHW2Campaign.big