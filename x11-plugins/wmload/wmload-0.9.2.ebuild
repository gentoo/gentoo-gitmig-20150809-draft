# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmload/wmload-0.9.2.ebuild,v 1.5 2004/11/24 23:16:45 weeve Exp $

inherit eutils

IUSE=""

DESCRIPTION="yet another dock application showing a system load gauge"
SRC_URI="http://www.cs.mun.ca/~gstarkes/wmaker/dockapps/files/${P}.tgz"
HOMEPAGE="http://www.cs.mun.ca/~gstarkes/wmaker/dockapps/sys.html#wmload"

DEPEND="virtual/x11"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~sparc"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-ComplexProgramTargetNoMan.patch
}

src_compile() {
	cd ${S}
	PATH="$PATH:/usr/X11R6/bin"
	xmkmf || die "xmkmf failed"
	emake CDEBUGFLAGS="${CFLAGS}" || die "Compilation failed"
}

src_install() {
	einstall DESTDIR=${D} BINDIR=/usr/bin || die "Installation failed"

	dodoc README

	insinto /usr/share/applications
	doins ${FILESDIR}/${PN}.desktop
}
