# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/libvisual-plugins/libvisual-plugins-0.1.6.ebuild,v 1.3 2004/10/17 09:53:07 dholm Exp $

IUSE=""

inherit eutils

DESCRIPTION="Visualization plugins for use with the libvisual framework."
HOMEPAGE="http://libvisual.sourceforge.net/"
SRC_URI="mirror://sourceforge/libvisual/${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86 ~ppc"

RDEPEND="virtual/opengl
	media-libs/glut
	media-libs/libvisual"

DEPEND="${RDEPEND}
	sys-apps/sed
	sys-apps/findutils"

src_unpack() {
	unpack ${A}

	cd ${S}
	find . -name Makefile.in |
		xargs sed -i "s:\$(prefix)/lib:@libdir@:"
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
