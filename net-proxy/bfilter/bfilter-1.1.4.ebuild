# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/bfilter/bfilter-1.1.4.ebuild,v 1.4 2011/03/29 06:17:49 nirbheek Exp $

EAPI=1 # needed for slot dependencies

WANT_AUTOMAKE="latest"
WANT_AUTOCONF="none"

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

pkg_setup() {
	if ! built_with_use --missing true dev-libs/boost threads ; then
		eerror "${PN} needs dev-libs/boost with threads support."
		die "Re-compile dev-libs/boost with USE=threads."
	fi
}

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}"/${P}-external-boost.patch
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
