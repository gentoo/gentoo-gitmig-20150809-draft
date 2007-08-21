# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sobby/sobby-0.4.4.ebuild,v 1.1 2007/08/21 12:32:34 dev-zero Exp $

inherit eutils

DESCRIPTION="Standalone Obby server"
HOMEPAGE="http://gobby.0x539.de/"
SRC_URI="http://releases.0x539.de/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="avahi"

RDEPEND=">=dev-cpp/glibmm-2.6
	>=dev-libs/libsigc++-2.0
	>=dev-libs/gmp-4.1.4
	>=dev-cpp/libxmlpp-2.6
	>=net-libs/obby-0.4.3"
DEPEND="dev-util/pkgconfig"

pkg_setup() {
	if use avahi && ! built_with_use net-libs/obby avahi ; then
		eerror "Please reinstall net-libs/obby with the avahi USE-flag enabled"
		eerror "for zeroconf/DNS-SD support or disable it for this package."
		die "Missing 'avahi' USE-flag for net-libs/obby"
	fi
}

src_compile() {
	econf \
		$(use_enable avahi zeroconf) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog NEWS README

	newconfd "${FILESDIR}/sobby-conf-0.4.3" sobby
	newinitd "${FILESDIR}/sobby-init-0.4.3" sobby
}

pkg_postinst() {
	elog "To start sobby, you can use the init script:"
	elog "    /etc/init.d/sobby start"
	elog ""
	elog "Please check the configuration in /etc/conf.d/sobby"
	elog "before you start sobby"
}
