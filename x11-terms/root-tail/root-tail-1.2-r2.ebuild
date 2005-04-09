# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/root-tail/root-tail-1.2-r2.ebuild,v 1.6 2005/04/09 13:43:35 corsair Exp $

inherit eutils flag-o-matic

DESCRIPTION="Terminal to display (multiple) log files on the root window"
HOMEPAGE="http://www.goof.com/pcg/marc/root-tail.html"
SRC_URI="http://www.goof.com/pcg/marc/data/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc amd64 ppc ppc64"
IUSE="kde debug"

RDEPEND="virtual/x11"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	use kde && epatch ${FILESDIR}/${P}-kde.patch
}

src_compile() {
	xmkmf -a
	sed -i 's|/usr/X11R6/bin|/usr/bin|' Makefile || die "sed Makefile failed"
	use debug && append-flags -DDEBUG
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install install.man || die "make install failed"
	dodoc Changes README
}
