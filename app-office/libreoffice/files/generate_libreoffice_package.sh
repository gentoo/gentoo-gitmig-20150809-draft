#!/bin/bash

# important: you need to use the most general CFLAGS to build the packages
# recommendation: 
#  * for x86  : CFLAGS="-march=i586 -mtune=generic -O2 -pipe -g"
#  * for amd64: CFLAGS="-march=x86-64 -mtune=generic -O2 -pipe -g"

die() {
	echo "${1}"
	exit 1
}

VERSION="3.5.4.2-r1"
BINVERSION="3.5.4.2-r1"

# first the default subset of useflags
IUSES_BASE="bash-completion binfilter branding cups dbus graphite gstreamer gtk nsplugin python vba webdav xmlsec -aqua -jemalloc -mysql -nlpsolver -odk -opengl -pdfimport -postgres -svg"

# now for the options
IUSES_J="java"
IUSES_NJ="-java"
IUSES_G="gnome eds"
IUSES_NG="-gnome -eds"
IUSES_K="kde"
IUSES_NK="-kde"

mkdir -p /etc/portage/package.use/

# compile the flavor
echo "Base"
echo "app-office/libreoffice ${IUSES_BASE} ${IUSES_NJ} ${IUSES_NG} ${IUSES_NK}" > /etc/portage/package.use/libreo
emerge -v =libreoffice-${VERSION} || die "emerge failed"
quickpkg libreoffice --include-config=y
mv /tmp/portage/packages/app-office/libreoffice-${VERSION}.tbz2 ./libreoffice-base-${BINVERSION}.tbz2  || die "Moving package failed"

echo "Base - java"
echo "app-office/libreoffice ${IUSES_BASE} ${IUSES_J} ${IUSES_NG} ${IUSES_NK}" > /etc/portage/package.use/libreo
emerge -v =libreoffice-${VERSION} || die "emerge failed"
quickpkg libreoffice --include-config=y
mv /tmp/portage/packages/app-office/libreoffice-${VERSION}.tbz2 ./libreoffice-base-java-${BINVERSION}.tbz2  || die "Moving package failed"

# kde flavor
echo "KDE"
echo "app-office/libreoffice ${IUSES_BASE} ${IUSES_NJ} ${IUSES_NG} ${IUSES_K}" > /etc/portage/package.use/libreo
emerge -v =libreoffice-${VERSION} || die "emerge failed"
quickpkg libreoffice --include-config=y
mv /tmp/portage/packages/app-office/libreoffice-${VERSION}.tbz2 ./libreoffice-kde-${BINVERSION}.tbz2  || die "Moving package failed"

echo "KDE - java"
echo "app-office/libreoffice ${IUSES_BASE} ${IUSES_J} ${IUSES_NG} ${IUSES_K}" > /etc/portage/package.use/libreo
emerge -v =libreoffice-${VERSION} || die "emerge failed"
quickpkg libreoffice --include-config=y
mv /tmp/portage/packages/app-office/libreoffice-${VERSION}.tbz2 ./libreoffice-kde-java-${BINVERSION}.tbz2  || die "Moving package failed"

# gnome flavor
echo "Gnome"
echo "app-office/libreoffice ${IUSES_BASE} ${IUSES_NJ} ${IUSES_G} ${IUSES_NK}" > /etc/portage/package.use/libreo
emerge -v =libreoffice-${VERSION} || die "emerge failed"
quickpkg libreoffice --include-config=y
mv /tmp/portage/packages/app-office/libreoffice-${VERSION}.tbz2 ./libreoffice-gnome-${BINVERSION}.tbz2  || die "Moving package failed"

echo "Gnome -java"
echo "app-office/libreoffice ${IUSES_BASE} ${IUSES_J} ${IUSES_G} ${IUSES_NK}" > /etc/portage/package.use/libreo
emerge -v =libreoffice-${VERSION} || die "emerge failed"
quickpkg libreoffice --include-config=y
mv /tmp/portage/packages/app-office/libreoffice-${VERSION}.tbz2 ./libreoffice-gnome-java-${BINVERSION}.tbz2  || die "Moving package failed"


for name in ./libreoffice-*-${BINVERSION}.tbz2 ; do 

  BN=`basename $name .tbz2`

  rm -rf tmp.lo
  mkdir -vp tmp.lo/p1 tmp.lo/p2
  cd tmp.lo/p1

  echo "Unpacking complete archive $BN.tbz2"
  tar xfvjp ../../$BN.tbz2

  echo "Moving debug info"
  mkdir -vp ../p2/usr/lib
  mv -v usr/lib/debug ../p2/usr/lib/

  echo "Re-packing program"
  tar cfvJ ../../bin-$BN.tar.xz --owner root --group root ./*

  echo "Re-packing debug info"
  cd ../p2
  tar cfvJ ../../debug-$BN.tar.xz --owner root --group root ./*

  echo "Removing unpacked files"
  cd ../..
  rm -rf tmp.lo

  echo "Done with $BN.tbz2"

done
