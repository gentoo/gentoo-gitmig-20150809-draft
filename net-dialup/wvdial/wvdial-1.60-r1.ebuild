# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/wvdial/wvdial-1.60-r1.ebuild,v 1.1 2009/06/20 09:40:56 mrness Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Excellent program to automatically configure PPP sessions"
HOMEPAGE="http://alumnit.ca/wiki/?WvDial"
SRC_URI="http://alumnit.ca/download/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc sparc x86"
IUSE=""

COMMON_DEPEND=">=net-libs/wvstreams-4.4"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig"
RDEPEND="${COMMON_DEPEND}
	net-dialup/ppp"

src_prepare() {
	epatch "${FILESDIR}/${P}-destdir.patch"
	epatch "${FILESDIR}/${P}-as-needed.patch"
	epatch "${FILESDIR}/${P}-dirent.patch"
}

src_install() {
	emake "DESTDIR=${D}" install || die "make install failed"

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
