# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/chmlib/chmlib-0.39-r1.ebuild,v 1.6 2009/04/11 17:28:31 armin76 Exp $

inherit eutils multilib flag-o-matic versionator

DESCRIPTION="Library for MS CHM (compressed html) file format plus extracting and http server utils"
HOMEPAGE="http://www.jedrea.com/chmlib/"
SRC_URI="http://www.jedrea.com/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ~ia64 ppc ppc64 x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-stdtypes.patch
	epatch "${FILESDIR}"/${P}-headers.patch
}

src_compile() {
	econf --enable-examples || die "econf failed"
	emake || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS NEWS README
}
