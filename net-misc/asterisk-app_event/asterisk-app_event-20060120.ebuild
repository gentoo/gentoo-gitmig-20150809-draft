# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-app_event/asterisk-app_event-20060120.ebuild,v 1.3 2009/08/29 17:39:29 robbat2 Exp $

inherit eutils

MY_PN="app_event"

DESCRIPTION="Asterisk plugin to generate a manger event from the dialplan"
HOMEPAGE="http://www.pbxfreeware.org/"
SRC_URI="http://www.netdomination.org/pub/asterisk/${P}.tar.bz2
	 mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"

DEPEND=">=net-misc/asterisk-1.2.0
	!=net-misc/asterisk-1.0*"

S=${WORKDIR}/${MY_PN}

src_unpack() {
	unpack ${A}
	cd ${S}

	# use asterisk-config
	epatch ${FILESDIR}/${MY_PN}-20050627-astcfg.diff
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	insinto /usr/$(get_libdir)/asterisk/modules
	doins app_event.so
}
