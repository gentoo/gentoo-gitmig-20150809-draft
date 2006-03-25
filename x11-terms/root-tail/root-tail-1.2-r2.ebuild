# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/root-tail/root-tail-1.2-r2.ebuild,v 1.9 2006/03/25 16:04:04 kloeri Exp $

inherit eutils flag-o-matic

DESCRIPTION="Terminal to display (multiple) log files on the root window"
HOMEPAGE="http://www.goof.com/pcg/marc/root-tail.html"
SRC_URI="http://www.goof.com/pcg/marc/data/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ppc ppc64 ~sparc x86"
IUSE="kde debug"

RDEPEND="|| ( x11-libs/libXext virtual/x11 )"
DEPEND=">=sys-apps/sed-4
	|| ( ( x11-misc/imake
			app-text/rman
			x11-misc/gccmakedep
		)
		virtual/x11
	)"

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
