# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/bfilter/bfilter-1.1.4-r1.ebuild,v 1.2 2011/03/29 06:17:49 nirbheek Exp $

EAPI=2

inherit eutils autotools

DESCRIPTION="An ad-filtering web proxy featuring an effective heuristic ad-detection algorithm"
HOMEPAGE="http://bfilter.sourceforge.net/"
SRC_URI="mirror://sourceforge/bfilter/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 sparc x86"
IUSE="X debug"

RDEPEND="sys-libs/zlib
	dev-libs/ace
	dev-libs/libsigc++:2
	X? ( dev-cpp/gtkmm:2.4 )
	dev-libs/boost"
DEPEND="${RDEPEND}
	dev-util/scons
	dev-util/pkgconfig"

RESTRICT="test" # boost's test API has changed

src_prepare() {
	epatch "${FILESDIR}"/${P}-external-boost.patch
	rm -rf "${S}"/boost
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable debug) \
		$(use_with X gui) \
		--without-builtin-boost || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	insinto /etc/bfilter
	doins "${FILESDIR}"/forwarding.xml

	dodoc AUTHORS ChangeLog "${FILESDIR}"/forwarding-proxy.xml
	dohtml doc/*

	newinitd "${FILESDIR}/bfilter.init" bfilter
	newconfd "${FILESDIR}/bfilter.conf" bfilter
}

pkg_preinst() {
	enewgroup bfilter
	enewuser bfilter -1 -1 -1 bfilter
}

pkg_postinst() {
	elog "The documentation is available at"
	elog "   http://bfilter.sourceforge.net/documentation.php"
	elog "For forwarding bfilter service traffic through a proxy,"
	elog "see forwarding-proxy.xml example installed in the doc directory."
}
