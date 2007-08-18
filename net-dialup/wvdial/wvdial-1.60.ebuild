# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/wvdial/wvdial-1.60.ebuild,v 1.1 2007/08/18 05:56:45 mrness Exp $

inherit eutils

DESCRIPTION="Excellent program to automatically configure PPP sessions"
HOMEPAGE="http://alumnit.ca/wiki/?WvDial"
SRC_URI="http://alumnit.ca/download/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=net-libs/wvstreams-4.4"
RDEPEND="${DEPEND}
	net-dialup/ppp"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${P}-destdir.patch"
}

src_install() {
	make "DESTDIR=${D}" install || die "make install failed"

	dodoc CHANGES FAQ MENUS README TODO
}

pkg_postinst() {
	elog
	elog "Use wvdialconf to automagically generate a configuration file."
	elog
	elog "Users have to be member of the dialout AND the uucp group"
	elog "to use wvdial!"
	elog
}
