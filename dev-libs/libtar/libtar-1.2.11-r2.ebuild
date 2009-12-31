# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtar/libtar-1.2.11-r2.ebuild,v 1.4 2009/12/31 17:25:38 ranger Exp $

inherit eutils

DESCRIPTION="C library for manipulating POSIX tar files"
HOMEPAGE="http://www.feep.net/libtar/"
SRC_URI="ftp://ftp.feep.net/pub/software/libtar/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="sys-libs/zlib"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-example-fix.patch
	sed -i '/INSTALL_PROGRAM/s: -s$::' */Makefile.in
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc ChangeLog README TODO
}
