# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-base/opengl-update/opengl-update-1.3.ebuild,v 1.11 2004/02/22 12:29:26 mr_bones_ Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Utility to change the OpenGL interface being used."
SRC_URI=""
HOMEPAGE="http://www.gentoo.org/"

SLOT="0"
KEYWORDS="x86 ppc sparc "
LICENSE="GPL-2"
DEPEND="virtual/glibc"
RDEPEND=$DEPEND

src_install() {
	newsbin ${FILESDIR}/opengl-update-${PV} opengl-update
}

