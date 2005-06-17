# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-app_iconv/asterisk-app_iconv-0.9.ebuild,v 1.1 2005/06/17 19:46:10 stkn Exp $

inherit eutils

MY_PN="app_iconv"

DESCRIPTION="Asterisk application plugin for character conversion"
HOMEPAGE="http://www.mezzo.net/asterisk/"
SRC_URI="http://www.mezzo.net/asterisk/${MY_PN}-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE=""

# depends on glibc's iconv support
DEPEND="sys-libs/glibc
	>=net-misc/asterisk-1.0.5-r1"

S=${WORKDIR}/${MY_PN}

src_unpack() {
	unpack ${A}

	cd ${S}
	# use asterisk-config...
	epatch ${FILESDIR}/${MY_PN}-0.8-astcfg.diff
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc README CHANGES
}
