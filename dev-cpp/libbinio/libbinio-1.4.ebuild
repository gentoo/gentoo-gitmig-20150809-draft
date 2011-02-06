# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libbinio/libbinio-1.4.ebuild,v 1.18 2011/02/06 07:44:06 leio Exp $

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
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
