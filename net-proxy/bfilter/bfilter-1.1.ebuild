# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/bfilter/bfilter-1.1.ebuild,v 1.1 2007/08/18 13:27:09 mrness Exp $

WANT_AUTOMAKE="1.9"

inherit eutils autotools

DESCRIPTION="An ad-filtering web proxy featuring an effective heuristic ad-detection algorithm"
HOMEPAGE="http://bfilter.sourceforge.net/"
SRC_URI="mirror://sourceforge/bfilter/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="X debug"

RDEPEND="sys-libs/zlib
	>=dev-libs/ace-5.4.6
	=dev-libs/libsigc++-2.0*
	X? ( >=dev-cpp/gtkmm-2.4 )"
DEPEND="${RDEPEND}
	dev-util/scons
	dev-util/pkgconfig
	dev-libs/boost"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}"/${P}-external-boost.patch
	epatch "${FILESDIR}"/${P}-date-test.patch
	eautomake
}

src_compile() {
	econf \
		$(use_enable debug) \
		$(use_with X gui) \
		--without-builtin-boost || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog
	dohtml doc/*

	newinitd "${FILESDIR}/bfilter.init" bfilter
	newconfd "${FILESDIR}/bfilter.conf" bfilter
}

pkg_preinst() {
	enewgroup bfilter
	enewuser bfilter -1 -1 -1 bfilter
}

pkg_postinst() {
	einfo "The documentation is available at"
	einfo "   http://bfilter.sourceforge.net/documentation.php"
}
