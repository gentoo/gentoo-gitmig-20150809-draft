# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdrkit/cdrkit-1.0_pre3.ebuild,v 1.2 2006/09/05 05:35:17 metalgod Exp $

inherit eutils toolchain-funcs

MY_P="${PN}-${PV/_/}"

DESCRIPTION="Cdrkit is a fork of the latest complete free cdrtools sources."
HOMEPAGE="http://debburn.alioth.debian.org/"
SRC_URI="http://debburn.alioth.debian.org/${MY_P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/libc
	>=dev-util/cmake-2.4"

S="${WORKDIR}/${MY_P}"

src_compile() {
	cmake \
		-DCMAKE_INSTALL_PREFIX=/usr \
		-DCMAKE_C_COMPILER=$(which $(tc-getCC))

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ABOUT Changelog FAQ FORK START TODO VERSION

	cd ${S}/doc/cdda2wav
	dodoc FAQ Frontends HOWTOUSE README TODO

	cd ${S}/doc/mkisofs
	dodoc README*

	cd ${S}/doc/READMEs
	dodoc README*
}
