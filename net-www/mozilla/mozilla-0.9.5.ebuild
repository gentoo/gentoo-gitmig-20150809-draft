# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Desktop Team <desktop@cvs.gentoo.org>
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/mozilla/mozilla-0.9.5.ebuild,v 1.1 2001/10/20 16:04:22 hallski Exp $

S=${WORKDIR}/mozilla
DESCRIPTION="The Mozilla web browser"
SRC_URI="ftp://ftp.mozilla.org/pub/mozilla/releases/mozilla${PV}/src/${PN}-source-${PV}.tar.gz"
HOMEPAGE="http://www.mozilla.org"

PROVIDE="virtual/x11-web-browser"

RDEPEND=">=gnome-base/ORBit-0.5.10-r1
	>=x11-libs/gtk+-1.2.10-r4
	>=media-libs/jpeg-6b
	>=media-libs/libpng-1.0.9
	app-arch/zip
	app-arch/unzip
	mozqt? ( x11-libs/qt-x11 )"

DEPEND="${RDEPEND}
	sys-devel/perl"

src_compile() {
	chown -R root.root *

	if [ "`use mozqt`" ] ; then
		myconf="--with-qt --enable-toolkit=qt --without-gtk"
	else
		myconf="--with-gtk --enable-toolkit=gtk"
	fi

	if [ -z "$DEBUG" ] ; then
		myconf="${myconf} --enable-strip-libs"
	fi

	./configure  --host=${CHOST}					\
		     --prefix=/usr/lib/mozilla 				\
		     --disable-tests					\
		     --disable-debug					\
		     --disable-dtd-debug				\
		     --disable-pedantic					\
		     --enable-xsl					\
		     --enable-crypto					\
		     --with-java-supplement				\
		     --enable-optimize=-O2				\
		     --with-default-mozilla-five-home=/usr/lib/mozilla	\
		     ${myconf} || die

	make || die
}

src_install () {
	dodir /usr/lib/mozilla/include
	cd ${S}/dist/include
	cp -LfR * ${D}/usr/lib/mozilla/include
#	rm ${D}/usr/lib/mozilla/include/*.h
	
#	cd ${S}/include
#	cp -f *.h ${D}/usr/lib/mozilla/include
#	cp -f nspr/*.h ${D}/usr/lib/mozilla/include/nspr
#	cp -f nspr/obsolete/*.h ${D}/usr/lib/mozilla/include/nspr/obsolete
#	cp -f nspr/private/*.h ${D}/usr/lib/mozilla/include/nspr/private
#	cp -f nspr/md/*.cfg ${D}/usr/lib/mozilla/include/nspr/md

	export MOZILLA_OFFICIAL=1
	export BUILD_OFFICIAL=1
	cd ${S}/xpinstall/packager
	make || die
	dodir /usr/lib

	tar xzf ${S}/dist/mozilla-`uname -m`-pc-linux-gnu.tar.gz 	\
	    -C ${D}/usr/lib

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

	# Needed to update the run time bindings for REGXPCOM 
	# (do not remove next line!)
	env-update
	/usr/lib/mozilla/regxpcom
	chmod g+r,o+r /usr/lib/mozilla/component.reg
}

