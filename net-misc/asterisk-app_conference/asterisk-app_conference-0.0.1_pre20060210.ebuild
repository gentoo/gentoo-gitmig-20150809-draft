# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-app_conference/asterisk-app_conference-0.0.1_pre20060210.ebuild,v 1.1 2006/05/06 15:18:49 stkn Exp $

inherit eutils

MY_PN="app_conference"
MY_P="${MY_PN}-${PV/0.0.1_pre/}"

DESCRIPTION="Asterisk application plugin for conferences"
HOMEPAGE="http://iaxclient.sourceforge.net/"
SRC_URI="http://www.netdomination.org/pub/asterisk/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""

# depends on glibc's iconv support
DEPEND="sys-libs/glibc
	>=net-misc/asterisk-1.2.0
	!=net-misc/asterisk-1.0*"

S=${WORKDIR}/${MY_PN}

src_unpack() {
	unpack ${A}

	cd ${S}
	# use asterisk-config...
	epatch ${FILESDIR}/${MY_PN}-20060210-astcfg.diff
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc README LICENSE
}
