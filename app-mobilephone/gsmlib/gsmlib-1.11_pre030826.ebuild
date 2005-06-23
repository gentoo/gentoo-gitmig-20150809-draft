# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/gsmlib/gsmlib-1.11_pre030826.ebuild,v 1.3 2005/06/23 01:15:43 agriffis Exp $

inherit eutils

RESTRICT="test"

MY_A=${PN}-pre${PV%_pre*}-${PV#*_pre}

DESCRIPTION="Library and Applications to access GSM mobile phones"
SRC_URI="http://www.pxh.de/fs/gsmlib/snapshots/${MY_A}.tar.gz"
HOMEPAGE="http://www.pxh.de/fs/gsmlib/"

DEPEND=""

IUSE=""
SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~amd64 ppc sparc x86"

S=${WORKDIR}/${PN}-${PV%_pre*}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/gsmlib-1.11-include-gcc34-fix.patch
}

src_compile() {
	econf || die
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS NEWS README
}
