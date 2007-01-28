# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/mgv/mgv-3.1.5-r1.ebuild,v 1.8 2007/01/28 05:57:00 genone Exp $

inherit eutils

IUSE=""

DESCRIPTION="Motif PostScript viewer loosely based on Ghostview"
SRC_URI="http://www.trends.net/~mu/srcs/${P}.tar.gz"
HOMEPAGE="http://www.trends.net/~mu/mgv.html"

KEYWORDS="~x86 ~sparc ~ppc"
LICENSE="GPL-2"
SLOT="0"

DEPEND="x11-libs/openmotif"
RDEPEND="${DEPEND}
	virtual/ghostscript"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-stderr.patch || die
}

src_compile() {
	econf || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog NEWS README
	dohtml doc/*.sgml

	# move config file to /etc/X11/app-defaults
	dodir /etc/X11/app-defaults
	mv ${D}/usr/share/mgv/${PV}/MGv ${D}/etc/X11/app-defaults
}

pkg_postinst() {
	elog "The default browser for help documents is netscape"
	elog "You can change it in /etc/mgv.conf"
}
