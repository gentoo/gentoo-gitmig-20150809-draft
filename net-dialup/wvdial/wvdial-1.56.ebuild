# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/wvdial/wvdial-1.56.ebuild,v 1.4 2006/04/24 02:39:32 metalgod Exp $

inherit eutils

DESCRIPTION="Excellent program to automatically configure PPP sessions"
HOMEPAGE="http://open.nit.ca/wiki/?page=WvDial"
SRC_URI="http://open.nit.ca/download/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ppc sparc x86"
IUSE=""

DEPEND=">=net-libs/wvstreams-4.2.2"
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
	einfo
	einfo "Use wvdialconf to automagically generate a configuration file."
	einfo
	einfo "Users have to be member of the dialout AND the uucp group"
	einfo "to use wvdial!"
	einfo
}
