### make bootup disk

- sudo /Applications/Install\ macOS\ Catalina.app/Contents/Resources/createinstallmedia --volume /Volumes/Catalina

### Errors
- IA app name cookie write failed  -- reboot system

### Cannot install without ensuring the file system is read-write
```
Modifying CloverPackage/package/Distribution file
Change functioncheckFileSystemIsWritable in the file to:

function checkFileSystemIsWritable() { var writable = true; return writable; }
Run buildme from command line
Select option 3 (make pkg)
Run newly created package from CloverPackage/sym/
```

### Reference Link
https://zhuanlan.zhihu.com/p/55991446
