# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# /home/cvsroot/gentoo-x86/net-www/mozilla/mozilla-0.9.ebuild,v 1.4 2001/06/07 01:45:52 achim Exp
# /home/cvsroot/gentoo-x86/net-www/mozilla/mozilla-0.9.4.ebuild,v 1.1 2001/09/22 09:07:50 blocke Exp


A=mozilla-source-${PV}.tar.gz
S=${WORKDIR}/mozilla
DESCRIPTION=""
SRC_URI="ftp://ftp.mozilla.org/pub/mozilla/releases/mozilla${PV}/src/${A}"
HOMEPAGE="http://www.mozilla.org"
PROVIDE="virtual/x11-web-browser"

DEPEND="sys-devel/perl >=gnome-base/ORBit-0.5.7
	>=x11-libs/gtk+-1.2.9
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.0.9
	app-arch/zip
	app-arch/unzip
	mozqt? ( x11-libs/qt-x11 )"
RDEPEND=">=gnome-base/ORBit-0.5.7
	>=x11-libs/gtk+-1.2.9
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.0.9
	app-arch/zip
	app-arch/unzip
	mozqt? ( x11-libs/qt-x11 )"

src_compile() {
    chown -R root.root *
    if [ "`use mozqt`" ] ; then
	myconf="--with-qt --enable-toolkit=qt --without-gtk --with-extentions=default,venkman"
    else
	myconf="--with-gtk --with-extentions=default,venkman,irc"
    fi
    ./configure --prefix=/usr/lib/mozilla --host=${CHOST} \
	$myconf --disable-tests --disable-debug --enable-jsd || die
    make || die
#    if [ ! "`use mozqt`" ] ; then
#      cd extensions/irc
#      make || die
#      cd ../..
#    fi

    ./configure --prefix=/usr/lib/mozilla --host=${CHOST} \
	$myconf --disable-tests --disable-debug || die
    make BUILD_MODULES=psm || die

}

src_install () {

    dodir /usr/lib/mozilla/include/nspr/{private,obsolete,md}
    cd dist/include
    cp -f *.h ${D}/usr/lib/mozilla/include
    cp -f nspr/*.h ${D}/usr/lib/mozilla/include/nspr
    cp -f nspr/obsolete/*.h ${D}/usr/lib/mozilla/include/nspr/obsolete
    cp -f nspr/private/*.h ${D}/usr/lib/mozilla/include/nspr/private
    cp -f nspr/md/*.cfg ${D}/usr/lib/mozilla/include/nspr/md

    export MOZILLA_OFFICIAL=1
    export BUILD_OFFICIAL=1
    cd ${S}/xpinstall/packager
    make || die
    dodir /usr/lib
    tar xzf ${S}/dist/mozilla-`uname -m`-pc-linux-gnu.tar.gz -C ${D}/usr/lib
    mv ${D}/usr/lib/package ${D}/usr/lib/mozilla

    exeinto /usr/bin
    doexe ${FILESDIR}/mozilla
    insinto /etc/env.d
    doins ${FILESDIR}/10mozilla
    dodoc LEGAL LICENSE README/mozilla/README*

    # Take care of non root execution
    # (seems the problem is that not all files are readible by the user)
    chmod -R g+r,o+r ${D}/usr/lib/mozilla

}

pkg_postinst () {

    # Take care of component registration
    export MOZILLA_FIVE_HOME="/usr/lib/mozilla"
    # Needed to update the run time bindings for REGXPCOM (do not remove next line!)
    env-update
    /usr/lib/mozilla/regxpcom
    chmod g+r,o+r /usr/lib/mozilla/component.reg

}

