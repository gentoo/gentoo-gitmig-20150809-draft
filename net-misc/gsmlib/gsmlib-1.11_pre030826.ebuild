# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gsmlib/gsmlib-1.11_pre030826.ebuild,v 1.2 2004/01/16 11:01:05 liquidx Exp $

MY_A=${PN}-pre${PV%_pre*}-${PV#*_pre}

DESCRIPTION="Library and Applications to access GSM mobile phones"
SRC_URI="http://www.pxh.de/fs/gsmlib/snapshots/${MY_A}.tar.gz"
HOMEPAGE="http://www.pxh.de/fs/gsmlib/"

DEPEND="virtual/glibc"

IUSE=""
SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 ~ppc ~sparc"

S=${WORKDIR}/${PN}-${PV%_pre*}

src_compile() {
	econf || die
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS NEWS README
}
