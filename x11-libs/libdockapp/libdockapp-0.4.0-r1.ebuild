# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libdockapp/libdockapp-0.4.0-r1.ebuild,v 1.12 2004/07/15 00:46:58 agriffis Exp $

IUSE=""

DESCRIPTION="Window Maker Dock Applet Library"
SRC_URI="http://solfertje.student.utwente.nl/~dalroi/libdockapp/files/${P}.tar.bz2"
HOMEPAGE="http://solfertje.student.utwente.nl/~dalroi/libdockapp/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 sparc amd64 ppc"

DEPEND="virtual/x11"

src_compile() {
	libtoolize --force --copy
	aclocal
	autoconf

	econf || die "configure failed"
	emake || die "parallel make failed"
}

src_install() {
	einstall || die "make install failed"

	dodoc README ChangeLog NEWS AUTHORS
}
