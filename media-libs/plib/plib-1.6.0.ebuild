# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/plib/plib-1.6.0.ebuild,v 1.9 2004/01/06 22:39:23 gmsoft Exp $

DESCRIPTION="multimedia library used by many games"
HOMEPAGE="http://plib.sourceforge.net/"
SRC_URI="http://plib.sourceforge.net/dist/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc amd64 alpha hppa"

DEPEND="sys-devel/autoconf"
RDEPEND="virtual/x11
	virtual/glut"

[ "${ARCH}" = "hppa" ] && export CXXFLAGS="${CXXFLAGS} -fPIC"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's:-O6 ::' configure.in
	autoconf || die
}

src_install() {
	einstall || die
}
