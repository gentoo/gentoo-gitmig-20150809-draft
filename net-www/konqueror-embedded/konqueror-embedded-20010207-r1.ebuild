# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/konqueror-embedded/konqueror-embedded-20010207-r1.ebuild,v 1.15 2004/07/14 06:16:58 mr_bones_ Exp $

DESCRIPTION="The Konqueror/Embedded project attempts to build up a special version of the web browsing component of the KDE browser Konqueror (in particular its html rendering engine khtml and its io subsystem)"
HOMEPAGE="http://www.konqueror.org/embedded.html"
SRC_URI="http://devel-home.kde.org/~hausmann/${PN}-snapshot.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE="qt-embedded"

S=${WORKDIR}/${PN}-snapshot

src_compile() {
	local myconf
	if use qt-embedded
	then
		export QTDIR=/opt/qt-embedded
		export PATH=$QTDIR/bin:$PATH
		export LDFLAGS="-L/usr/lib -lmng -ljpeg"
		myconf="--with-qt-dir=$QTDIR --enable-qt-embedded --enable-static --disable-shared --prefix=/usr/embedded"
	else
		myconf="--prefix=/usr"
	fi
	/configure ${myconf} --host=${CHOST} --with-ssl-dir=/usr || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	if use qt-embedded
	then
		dodir /usr/embedded/bin
		mv ${D}/usr/embedded/konq* ${D}/usr/embedded/bin
	else
		dodir /usr/bin
		# i don't know what an embedded konq loks like, bt it had better not
		# conflict with the main konqueror of kde! - danarmak
		mv ${D}/usr/konq* ${D}/usr/bin
	fi
}
