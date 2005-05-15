# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/gsmlib/gsmlib-1.11_pre041028.ebuild,v 1.1 2005/05/15 20:19:12 mrness Exp $

inherit eutils

MY_A=${PN}-pre${PV%_pre*}-${PV#*_pre}

DESCRIPTION="Library and Applications to access GSM mobile phones"
SRC_URI="http://www.pxh.de/fs/gsmlib/snapshots/${MY_A}.tar.gz"
HOMEPAGE="http://www.pxh.de/fs/gsmlib/"

DEPEND=""

IUSE=""
SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"

RESTRICT="maketest"

S=${WORKDIR}/${PN}-${PV%_pre*}

src_unpack() {
	unpack ${A}
	cd ${S}

	# Fix gsm_map_key.h for gsm_map_key.h
	epatch ${FILESDIR}/gsmlib-1.11-include-gcc34-fix.patch

}

src_compile() {
	econf
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS NEWS README
}

