# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/weex/weex-2.6.1.5.ebuild,v 1.4 2004/08/09 22:46:23 slarti Exp $

inherit eutils

DESCRIPTION="Automates maintaining a web page or other FTP archive."
HOMEPAGE="http://weex.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="x86 ~amd64"

IUSE="nls"

DEPEND="sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	cd ${S}
	use amd64 && epatch ${FILESDIR}/${P}-va_list.patch
}

src_compile() {
	econf $(use_enable nls) || die
	emake || die
}

src_install() {
	einstall || die
	dodoc doc/TODO* doc/README* doc/FAQ* doc/sample* doc/ChangeLog* \
		doc/BUG* doc/THANK*
}
