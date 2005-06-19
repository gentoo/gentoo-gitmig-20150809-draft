# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/karamba/karamba-0.17-r2.ebuild,v 1.2 2005/06/19 20:23:14 smithj Exp $

inherit kde

DESCRIPTION="A KDE program that displays a lot of various information right on your desktop."
HOMEPAGE="http://www.efd.lth.se/~d98hk/karamba/"
SRC_URI="http://www.efd.lth.se/~d98hk/karamba/src/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""

need-kde 3.1

src_unpack() {
	kde_src_unpack
	epatch ${FILESDIR}/${P}-configure-arts.patch
}

src_compile() {
	local myconf="--enable-libsuffix="

	kde_src_compile all
}

src_install () {
	emake DESTDIR=${D} install || die "install failed"
	dodir /usr/share/doc/${P} /usr/share/karamba/themes /usr/share/karamba/bin
	mv ${D}/usr/share/doc/* ${D}/usr/share/doc/${P}
	keepdir /usr/share/karamba/themes/.keep
	keepdir /usr/share/karamba/bin/.keep

	dodir /etc/env.d
	cp ${FILESDIR}/karamba-env ${D}/etc/env.d/99karamba
}
