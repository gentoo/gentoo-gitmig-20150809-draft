# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvdnav/libdvdnav-9999.ebuild,v 1.5 2012/04/12 23:40:17 vapier Exp $

EAPI=4
WANT_AUTOCONF=2.5

inherit autotools subversion

DESCRIPTION="Library for DVD navigation tools"
HOMEPAGE="http://dvdnav.mplayerhq.hu/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DOCS=( AUTHORS DEVELOPMENT-POLICY.txt ChangeLog TODO doc/dvd_structures README )

ESVN_REPO_URI="svn://svn.mplayerhq.hu/dvdnav/trunk/libdvdnav"
ESVN_PROJECT="libdvdnav"

src_prepare() {
	subversion_src_prepare
	epatch "${FILESDIR}"/${PN}-4.2.0-pkgconfig.patch
	eautoreconf
}

src_install() {
	default
	rm -f "${ED}"usr/lib*/${PN}*.la
}
