# You'll ahve to update the paths here...

ant release
jarsigner -verbose -sigalg MD5withRSA -digestalg SHA1 -keystore ~/Android/io.kos.keystore bin/AntiGuard-release-unsigned.apk io.kos
~/Tools/android-sdk-linux/tools/zipalign -v 4 bin/AntiGuard-release-unsigned.apk bin/AntiGuard.apk


mv bin/AntiGuard.apk .

ant clean
