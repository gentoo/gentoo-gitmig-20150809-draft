# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/skkserv/skkserv-9.6-r3.ebuild,v 1.8 2011/02/13 19:11:17 armin76 Exp $

inherit eutils

MY_P="skk${PV}mu"

DESCRIPTION="Dictionary server for the SKK Japanese-input software"
HOMEPAGE="http://openlab.ring.gr.jp/skk/"
SRC_URI="http://openlab.ring.gr.jp/skk/maintrunk/museum/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=">=app-i18n/skk-jisyo-200210"
PROVIDE="virtual/skkserv"

S="${WORKDIR}/skk-${PV}mu"

src_unpack() {
	unpack ${A}
	cd "${S}"/skkserv
	epatch "${FILESDIR}"/${P}-segfault-gentoo.patch
	epatch "${FILESDIR}"/${P}-inet_ntoa-gentoo.patch
}

src_compile() {
	econf --libexecdir=/usr/sbin || die "econf failed"
	cd skkserv
	emake || die
}

src_install() {
	cd skkserv
	dosbin skkserv || die

	newinitd "${FILESDIR}"/skkserv.initd skkserv
}
