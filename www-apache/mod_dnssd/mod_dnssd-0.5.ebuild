# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_dnssd/mod_dnssd-0.5.ebuild,v 1.1 2007/09/09 10:27:16 hollow Exp $

inherit apache-module eutils

KEYWORDS="~amd64 ~x86"

DESCRIPTION="mod_dnssd is an Apache module which adds Zeroconf support via DNS-SD using Avahi"
HOMEPAGE="http://0pointer.de/lennart/projects/mod_dnssd/"
SRC_URI="http://0pointer.de/lennart/projects/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
IUSE="doc"

DEPEND="net-dns/avahi"
RDEPEND="${DEPEND}"

APACHE2_MOD_CONF="80_${PN}"
APACHE2_MOD_DEFINE="DNSSD"

need_apache2

pkg_setup() {
	if ! built_with_use net-dns/avahi dbus; then
		eerror "net-dns/avahi needs USE=dbus"
		die "net-dns/avahi needs USE=dbus"
	fi
}

src_compile() {
	econf --with-apxs=${APXS2} --disable-lynx || die "econf failed"
	emake || die "emake failed"
}
