# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmdate/wmdate-0.7.ebuild,v 1.7 2004/12/05 15:27:34 slarti Exp $

inherit eutils

IUSE=""

DESCRIPTION="yet another date-display dock application"
SRC_URI="http://solfertje.student.utwente.nl/~dalroi/${PN}/files/${P}.tar.gz"
HOMEPAGE="http://solfertje.student.utwente.nl/~dalroi/applications.php"

DEPEND="virtual/x11
	>=x11-libs/libdockapp-0.4.0-r1"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ppc64 ~sparc ~amd64"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-ComplexProgramTargetNoMan.patch
}

src_compile() {
	cd ${S}
	PATH="$PATH:/usr/X11R6/bin"
	xmkmf -a
	emake CDEBUGFLAGS="${CFLAGS}" || die "make failed"
}

src_install() {
	einstall DESTDIR=${D} BINDIR=/usr/bin || DIE "make install failed"

	dodoc README

	insinto /usr/share/applications
	doins ${FILESDIR}/${PN}.desktop
}
