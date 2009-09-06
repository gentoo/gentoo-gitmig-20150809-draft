# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/motor/motor-3.4.0-r2.ebuild,v 1.2 2009/09/06 17:09:22 idl0r Exp $

inherit eutils

DESCRIPTION="text mode based programming environment for Linux"
HOMEPAGE="http://thekonst.net/en/motor"
SRC_URI="http://thekonst.net/download/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"
IUSE="nls"

RDEPEND=">=sys-libs/ncurses-5.2"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/motor-3.2.2-security.patch"
	epatch "${FILESDIR}/motor-${PV}-gcc43.patch"
}

src_compile() {
	econf `use_enable nls` || die
	emake || die
}

src_install() {
	einstall || die

	dodoc AUTHORS README TODO FAQ ChangeLog
	docinto tutorial
	dohtml -r tutorial/*
}
