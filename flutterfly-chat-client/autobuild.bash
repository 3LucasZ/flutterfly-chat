#!/bin/zsh

echo Starting build
export PATH="/Users/LucasZ/Developer/flutter/bin":$PATH
flutter build web
cp -r $HOME/AndroidStudioProjects/flask_flutter_websockets/build/web $HOME/Desktop/ServerForFlutterApp
echo Build finished successfully