# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/3dfm/3dfm-1.0.ebuild,v 1.5 2004/10/31 02:15:37 swegener Exp $

DESCRIPTION="OpenGL-based 3D File Manager"
HOMEPAGE="http://sourceforge.net/projects/innolab/"
SRC_URI="mirror://sourceforge/innolab/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="virtual/opengl
	virtual/glut"

src_install() {
	make DESTDIR=${D} install || die "install failed"
	mv ${D}/usr/bin/interface ${D}/usr/bin/3dfm

	dodoc AUTHORS ChangeLog README
}
