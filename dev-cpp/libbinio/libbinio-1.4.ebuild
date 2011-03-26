# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libbinio/libbinio-1.4.ebuild,v 1.19 2011/03/26 13:03:29 spock Exp $

inherit eutils

KEYWORDS="alpha amd64 hppa ~mips ppc ppc64 sparc x86 ~x86-fbsd"

DESCRIPTION="Binary I/O stream class library"
HOMEPAGE="http://libbinio.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-cstdio.patch"
	epatch "${FILESDIR}/${P}-texi.patch"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
