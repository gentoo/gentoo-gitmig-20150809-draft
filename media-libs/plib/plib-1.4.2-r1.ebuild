# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/plib/plib-1.4.2-r1.ebuild,v 1.10 2004/03/19 07:56:04 mr_bones_ Exp $

SRC_URI="http://plib.sourceforge.net/dist/${P}.tar.gz"
HOMEPAGE="http://plib.sourceforge.net/"
DESCRIPTION="multimedia library used by many games"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 sparc"

DEPEND="sys-devel/autoconf"
RDEPEND="virtual/x11
	virtual/glut"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp configure.in configure.in.orig
	sed -e 's:-O6 ::' configure.in.orig > configure.in
	rm configure
	autoconf || die
}

src_install() {
	einstall || die
}
