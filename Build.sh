set -e
# export SDK_DIR=~/Documents/CLT/Library/Developer/CommandLineTools/SDKs/MacOSX10.15.sdk
# -I $SDK_DIR/usr/include/ \
# -F $SDK_DIR/System/Library/Frameworks/ \
# -I $SDK_DIR/usr/include/ \
# -I "$SDK_DIR/System/Library/Frameworks/Kernel.framework/Headers/" \

clang src/MochaHelper.c -o out/MochaHelper
rm -f dist/intermediates/Root/usr/local/bin/MochaHelper
cp out/MochaHelper dist/intermediates/Root/usr/local/bin/

clang -fobjc-arc -framework Cocoa src/Mocha.m -o out/Mocha
rm -f dist/intermediates/Root/Applications/Mocha.app/Contents/MacOS/Mocha
cp out/Mocha dist/intermediates/Root/Applications/Mocha.app/Contents/MacOS/

pkgbuild --scripts dist/intermediates/Scripts --root dist/intermediates/Root --identifier tk.an0n.Mocha dist/Mocha.pkg

