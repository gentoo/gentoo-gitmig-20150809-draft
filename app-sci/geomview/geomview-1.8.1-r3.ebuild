# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/geomview/geomview-1.8.1-r3.ebuild,v 1.1 2004/03/05 08:02:41 nerdboy Exp $

DESCRIPTION="Interactive Geometry Viewer"
SRC_URI="http://ftp1.sourceforge.net/geomview/geomview-1.8.1.tar.gz"
HOMEPAGE="http://geomview.sourceforge.net"

KEYWORDS="~x86 ~sparc ~ppc"
LICENSE="LGPL-2.1"
SLOT="0"
S="${WORKDIR}/${P}"

DEPEND="dev-lang/tk
	x11-libs/xforms
	x11-libs/lesstif
	virtual/opengl"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p0 < ${FILESDIR}/${P}-stdiostream.diff || die
	patch -p1 < ${FILESDIR}/${P}-configure.diff || die
	}

src_compile() {
	econf || die "could not configure"
	make || die "make failed"
}

src_install() {
	make DESTDIR=${D} install
}
