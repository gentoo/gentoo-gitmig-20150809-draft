# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-app_iconv/asterisk-app_iconv-0.9.2.ebuild,v 1.1 2006/04/15 23:14:56 stkn Exp $

inherit eutils toolchain-funcs

MY_PN="app_iconv"

DESCRIPTION="Asterisk application plugin for character conversion"
HOMEPAGE="http://www.mezzo.net/asterisk/"
SRC_URI="http://www.mezzo.net/asterisk/${MY_PN}-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"

DEPEND="sys-libs/glibc
	>=net-misc/asterisk-1.0.5-r2"

S=${WORKDIR}/${MY_PN}-${PV}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${MY_PN}-0.9.2-gentoo.diff

	# patch for asterisk-1.2.x callerid handling
	has_version ">=net-misc/asterisk-1.2.0" && \
		epatch ${FILESDIR}/${MY_PN}-${PV}-ast12.diff
}

src_compile() {
	emake -j1 || die "make failed"
}

src_install() {
	insinto /usr/$(get_libdir)/asterisk/modules
	doins app_iconv.so
}
