# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gtktrain/gtktrain-0.9b.ebuild,v 1.1 2002/06/10 02:01:53 rphillips Exp $

DESCRIPTION="GUI app for calculating fastest train routes"
SRC_URI="http://www.on.rim.or.jp/~katamuki/software/train/${P}.tar.gz"
HOMEPAGE="http://www.on.rim.or.jp/~katamuki/software/train/"
LICENSE="GPL-2"
DEPEND=">=dev-libs/libtrain-0.9b
	>=gnome-base/gnome-libs-1.4.1.2-r1"

src_compile() {
	if [ -z "`use nls`" ] ; then
		NLS_OPTION="--disable-nls"
	fi

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${NLS_OPTION} || die "./configure failed"

	emake || die
}

src_install () {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die
}

pkg_postinst () {
	einfo "Japanese train routes are located: "
	einfo "    http://www.oohito.com/data/train/index.htm"
}
