# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/plib/plib-1.6.0.ebuild,v 1.2 2002/12/09 04:26:13 manson Exp $

S=${WORKDIR}/${P}
SRC_URI="http://plib.sourceforge.net/dist/${P}.tar.gz"
HOMEPAGE="http://plib.sourceforge.net"
DESCRIPTION="plib: a multimedia library used by many games"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~x86 ~sparc "

DEPEND="sys-devel/autoconf"
RDEPEND="virtual/x11
	virtual/glut"

src_unpack() {
	unpack $A
	cd $S
	cp configure.in configure.in.orig
	sed -e 's:-O6 ::' configure.in.orig > configure.in
	rm configure
	autoconf
}

src_install() {
	einstall || die
}
