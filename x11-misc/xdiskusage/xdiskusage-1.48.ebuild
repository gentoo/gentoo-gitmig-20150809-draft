# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xdiskusage/xdiskusage-1.48.ebuild,v 1.5 2006/09/21 12:14:51 nelchael Exp $

inherit eutils

DESCRIPTION="front end to xdu for viewing disk usage graphically under X11"
SRC_URI="http://xdiskusage.sourceforge.net/${P}.tgz"
HOMEPAGE="http://xdiskusage.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DEPEND="x11-libs/fltk
	virtual/glut"

src_unpack() {

	unpack ${A}
	epatch "${FILESDIR}/${P}-amd64.patch"

}

src_compile() {
	econf || die "configure failed"

	make \
		CXXFLAGS="$CXXFLAGS `fltk-config --cxxflags`" \
		LDLIBS="`fltk-config --ldflags`" \
		|| die "parallel make failed"
}

src_install() {
	dobin xdiskusage
	doman xdiskusage.1
	dodoc README
}
