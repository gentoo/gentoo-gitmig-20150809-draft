# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# /home/cvsroot/gentoo-x86/skel.build,v 1.2 2001/02/15 18:17:31 achim Exp
# $Header: /var/cvsroot/gentoo-x86/app-text/mgv/mgv-3.1.5-r1.ebuild,v 1.3 2004/02/12 13:20:44 lanius Exp $

inherit eutils

IUSE=""

DESCRIPTION="Motif PostScript viewer loosely based on Ghostview"
SRC_URI="http://www.trends.net/~mu/srcs/${P}.tar.gz"
HOMEPAGE="http://www.trends.net/~mu/mgv.html"

KEYWORDS="~x86 ~sparc"
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
	einfo "The default browser for help documents is netscape"
	einfo "You can change it in /etc/mgv.conf"
}
