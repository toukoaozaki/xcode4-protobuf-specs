xcode4-protobuf-specs
====================

This project is for language and file spec files for editing
[Google Protocol Buffer Specs][protobuf] in [Xcode 4][Xcode].

The installer script and instructions are derived from [Lua Support for Xcode 4+][Lua-In-Xcode].

[protobuf]: http://code.google.com/apis/protocolbuffers/docs/overview.html
[Xcode]: http://developer.apple.com/technologies/tools/
[Lua-In-Xcode]: https://github.com/breinhart/Lua-In-Xcode/

Installing These Files
----------------------

1. Download install.sh and protobuf.xclangspec
2. Open install.sh and change the DVTFOUNDATION_PATH if necessary. You probably do not need to change this if you are on Xcode 4.3+
3. Make sure Xcode is closed
4. Run install.sh from the terminal with sudo (i.e. 'sudo install.sh')
5. Enter your admin password and hit enter
6. Open Xcode and notice the 'Protocol Buffer' entry under "Editor->Syntax Coloring"
