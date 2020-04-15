#!/bin/sh

cd

echo "[+] --- cleanup"
if [ -d ~/dxvk ] || [ -d ~/artifacts/dxvk* ]; then
    rm -rf ~/dxvk
    rm -rf ~/artifacts/dxvk*
fi

echo "[+] --- pulling"
if ! git clone https://github.com/doitsujin/dxvk.git; then
    echo "[-] --- cant pull repo - exit"
    exit 1
fi

if [ -f ~/dxvk/package-release.sh ]; then
    echo "[+] --- building"
    if ~/dxvk/package-release.sh master ~/artifacts/ --no-package; then
        echo "[+] --- binaries in artifacts"
        echo "[!] --- you can now use:"
        echo "[!] --- export WINEPREFIX=/path/to/.wine-prefix"
        echo "[!] --- /path/to/artifacts/setup_dxvk.sh install"
        exit 0
    else
        echo "[-] --- build not succesfull"
        exit 1
    fi
fi
