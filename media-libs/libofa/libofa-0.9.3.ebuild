# Copyright 2006-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libofa/libofa-0.9.3.ebuild,v 1.3 2006/08/30 18:57:50 carlo Exp $

inherit eutils

DESCRIPTION="Open Fingerprint Architecture"
HOMEPAGE="http://www.musicdns.org/"
SRC_URI="http://www.musicdns.org/themes/musicdns_org/downloads/${P}.tar.gz"

LICENSE="|| ( APL-1.0 GPL-2 )"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-libs/expat
	net-misc/curl
	sci-libs/fftw"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	[[ "${CXXFLAGS}" != "${CXXFLAGS/-ffast-math/}" ]] && \
		die "Correct your C[XX]FLAGS. Using -ffast-math is unsafe and not supported."
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/libofa-0.9.3-gcc-4.patch
}

src_compile() {
 	econf || die "configure failed"
	emake || die "emake failed"
}
src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README
}
