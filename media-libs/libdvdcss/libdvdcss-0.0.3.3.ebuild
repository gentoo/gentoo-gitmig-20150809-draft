# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvdcss/libdvdcss-0.0.3.3.ebuild,v 1.7 2002/08/14 13:08:09 murphy Exp $

MY_PV="`echo ${PV} |sed -e 's/\./\.ogle/3'`"
S="${WORKDIR}/${PN}-${MY_PV}"
DESCRIPTION="A portable abstraction library for DVD decryption"
SRC_URI="http://www.dtek.chalmers.se/groups/dvd/dist/${PN}-${MY_PV}.tar.gz"
HOMEPAGE="http://www.dtek.chalmers.se/groups/dvd/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/glibc"

src_compile() {

	econf --infodir=/usr/share/info ||die
	make || die
}

src_install() {
	
	einstall || die
	dodoc AUTHORS COPYING ChangeLog README TODO
}
