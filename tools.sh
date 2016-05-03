# remove_CLI_tools.sh
# written by cocoanetics:http://www.cocoanetics.com/2012/07/you-dont-need-the-xcode-command-line-tools/
# modified by yoneken

#!/bin/sh

RECEIPT_FILE1=/var/db/receipts/com.apple.pkg.DevSDK.bom
RECEIPT_PLIST1=/var/db/receipts/com.apple.pkg.DevSDK.plist
RECEIPT_FILE2=/var/db/receipts/com.apple.pkg.clang.bom
RECEIPT_PLIST2=/var/db/receipts/com.apple.pkg.clang.plist
RECEIPT_FILE3=/var/db/receipts/com.apple.pkg.llvm-gcc4.2.bom
RECEIPT_PLIST3=/var/db/receipts/com.apple.pkg.llvm-gcc4.2.plist
RECEIPT_FILE4=/var/db/receipts/com.apple.pkg.DeveloperToolsCLI.bom
RECEIPT_PLIST4=/var/db/receipts/com.apple.pkg.DeveloperToolsCLI.plist

if [ ! -f "$RECEIPT_FILE4" ]
then
  echo "Command Line Tools not installed."
  exit 1
fi

echo "Command Line Tools installed, removing ..."

# Need to be at root
cd /

# Remove files and dirs mentioned in the "Bill of Materials" (BOM)
lsbom -fls $RECEIPT_FILE1 $RECEIPT_FILE2 $RECEIPT_FILE3 $RECEIPT_FILE4 | sudo xargs -I{} rm -r "{}"

# remove the receipt
sudo rm $RECEIPT_FILE1 $RECEIPT_FILE2 $RECEIPT_FILE3 $RECEIPT_FILE4

# remove the plist
sudo rm $RECEIPT_PLIST1 $RECEIPT_PLIST2 $RECEIPT_PLIST3 $RECEIPT_PLIST4

echo "Done! Please restart XCode to have Command Line Tools appear as uninstalled."
