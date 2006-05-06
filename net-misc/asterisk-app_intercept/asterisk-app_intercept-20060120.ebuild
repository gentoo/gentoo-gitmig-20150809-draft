# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-app_intercept/asterisk-app_intercept-20060120.ebuild,v 1.1 2006/05/06 15:23:37 stkn Exp $

inherit eutils

MY_PN="app_intercept"

DESCRIPTION="Asterisk plugin to intercept an unanswered call"
HOMEPAGE="http://www.pbxfreeware.org/"
SRC_URI="http://www.netdomination.org/pub/asterisk/${P}.tar.bz2
	 mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"

DEPEND=">=net-misc/asterisk-1.2.0
	!=net-misc/asterisk-1.0*"

S=${WORKDIR}/${MY_PN}

src_unpack() {
	unpack ${A}
	cd ${S}

	# use asterisk-config
	epatch ${FILESDIR}/${MY_PN}-20050623-astcfg.diff
}

src_compile() {
	emake -j1 || die "make failed"
}

src_install() {
	insinto /usr/$(get_libdir)/asterisk/modules
	doins app_intercept.so
}
