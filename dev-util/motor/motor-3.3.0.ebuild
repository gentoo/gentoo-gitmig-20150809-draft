# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/motor/motor-3.3.0.ebuild,v 1.1 2004/07/24 17:54:25 liquidx Exp $

DESCRIPTION="text mode based programming environment for Linux"
HOMEPAGE="http://thekonst.net/en/motor"
SRC_URI="http://thekonst.net/download/motor-3.3.0.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE="nls"

DEPEND=">=sys-libs/ncurses-5.2
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${P}

src_compile() {
	econf `use_enable nls` || die
	emake || die
}

src_install() {
	einstall || die

	dodoc AUTHORS COPYING README TODO FAQ ChangeLog
	docinto tutorial
	dohtml -r tutorial/*
}
