# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-base/opengl-update/opengl-update-1.4.ebuild,v 1.1 2002/09/07 21:35:08 azarah Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Utility to change the OpenGL interface being used."
SRC_URI=""
HOMEPAGE="http://www.gentoo.org/"

KEYWORDS="x86 ppc sparc sparc64"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"


src_install() {
	newsbin ${FILESDIR}/opengl-update-${PV} opengl-update
}

