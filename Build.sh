set -e
export SDK_DIR=~/Documents/CLT/Library/Developer/CommandLineTools/SDKs/MacOSX10.15.sdk

clang \
-I $SDK_DIR/usr/include/ \
MochaHelper.c -o MochaHelper
rm -f PayloadRoot/usr/bin/MochaHelper
cp MochaHelper PayloadRoot/usr/bin/

clang -fobjc-arc -framework Cocoa \
-F $SDK_DIR/System/Library/Frameworks/ \
-I $SDK_DIR/usr/include/ \
Mocha.m -o Mocha
rm -f PayloadRoot/Applications/Mocha.app/Contents/MacOS/Mocha
cp Mocha PayloadRoot/Applications/

pkgbuild --scripts scripts --root PayloadRoot --identifier tk.an0n.mocha Mocha.pkg

# -I "$SDK_DIR/System/Library/Frameworks/Kernel.framework/Headers/" \
