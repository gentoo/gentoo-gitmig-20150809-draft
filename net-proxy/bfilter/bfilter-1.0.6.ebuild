# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/bfilter/bfilter-1.0.6.ebuild,v 1.1 2006/09/20 17:54:39 mrness Exp $

inherit eutils

DESCRIPTION="An ad-filtering web proxy featuring an effective heuristic ad-detection algorithm"
HOMEPAGE="http://bfilter.sourceforge.net/"
SRC_URI="mirror://sourceforge/bfilter/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="X debug"

RDEPEND="sys-libs/zlib
	>=dev-libs/ace-5.4.6
	=dev-libs/libsigc++-2.0*
	X? ( >=dev-cpp/gtkmm-2.4 )"
DEPEND="${RDEPEND}
	dev-util/scons
	dev-util/pkgconfig"

src_compile() {
	econf `use_enable debug` `use_with X gui` || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	doman "${FILESDIR}/bfilter.8"

	dodoc AUTHORS ChangeLog
	dohtml doc/*.png doc/*.jpg doc/*.html

	newinitd "${FILESDIR}/bfilter.init" bfilter
	newconfd "${FILESDIR}/bfilter.conf" bfilter
}

pkg_preinst() {
	enewgroup bfilter
	enewuser bfilter -1 -1 -1 bfilter
}

pkg_postinst() {
	if has_version "=${CATEGORY}/${PN}-0.9.4" ; then
		ewarn "Please note that the filtering configuration files have been changed."
		ewarn "Any custom settings defined in the rules and rules.local files"
		ewarn "need to be converted to the new url and url.local files"
		ewarn "(the old rules and rules.local can then be deleted). "
		ewarn "See http://bfilter.sourceforge.net/doc/url-patterns.php for further details."
	fi
}
