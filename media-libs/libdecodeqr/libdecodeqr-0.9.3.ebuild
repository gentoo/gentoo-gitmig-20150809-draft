# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdecodeqr/libdecodeqr-0.9.3.ebuild,v 1.2 2008/11/07 09:44:17 robbat2 Exp $

inherit eutils flag-o-matic multilib

DESCRIPTION="libdecodeqr is a C/C++ library for decoding QR code based on JIS X 0510 and ISO/IEC18004."
HOMEPAGE="http://trac.koka-in.org/libdecodeqr"
# Upstream uses Trac, which causes FUN.
# http://trac.koka-in.org/libdecodeqr/attachment/wiki/WikiStart/libdecodeqr-0.9.3.tar.bz2?format=raw
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="media-libs/opencv"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}/src"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-makefile.patch
}

src_compile() {
	append-flags -I/usr/include/opencv
	econf LDFLAGS="${LDFLAGS//-Wl,/ }" || die
	emake libdecodeqr || die
	emake || die
}

src_install() {
	mkdir -pv "${D}"/usr/$(get_libdir) "${D}"/usr/include
	emake install DESTDIR="${D}" || die
}
