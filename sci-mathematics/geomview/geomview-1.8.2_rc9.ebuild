# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/geomview/geomview-1.8.2_rc9.ebuild,v 1.1 2007/04/04 06:08:02 nerdboy Exp $

inherit eutils flag-o-matic

DESCRIPTION="Interactive Geometry Viewer"
SRC_URI="http://mesh.dl.sourceforge.net/sourceforge/geomview/${P/_/-}.tar.bz2"
HOMEPAGE="http://geomview.sourceforge.net"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

DEPEND="dev-lang/tk
	x11-libs/xforms
	x11-libs/lesstif
	virtual/opengl"

S="${WORKDIR}/${P/_/-}"

src_compile() {
	append-flags "-DGL_GLEXT_LEGACY"
	econf || die "could not configure"
	make || die "make failed"
}

src_install() {
	emake DESTDIR=${D} install || die "make install failed"
}
