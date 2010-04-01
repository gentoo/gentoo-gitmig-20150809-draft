# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/desktopcouch/desktopcouch-0.6.1-r1.ebuild,v 1.1 2010/04/01 02:22:49 neurogeek Exp $

PYTHONDEPEND="2"
EAPI="2"

inherit distutils
inherit eutils

DESCRIPTION="Desktop-oriented interface to CouchDB"
HOMEPAGE="https://launchpad.net/desktopcouch"
SRC_URI="http://launchpad.net/desktopcouch/trunk/${PV}/+download/${P}.tar.gz"
LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=">=dev-python/python-distutils-extra-2.12"
RDEPEND=">=dev-db/couchdb-0.10.0
		>=dev-python/gnome-keyring-python-2.22.3-r1
		>=dev-python/couchdb-python-0.6
		>=dev-python/oauth-1.0.1
		>=dev-python/simplejson-2.0.9-r1
		>=dev-python/twisted-8.2.0-r2
		>=net-dns/avahi-0.6.24-r2[python]"
RESTRICT="test"

src_prepare() {
	epatch "${FILESDIR}/${PN}-setup_hardlinks.patch"
}

src_install() {
	distutils_src_install

	exeinto "${ROOT}/usr/lib/${PN}"
	doexe "bin/desktopcouch-stop"
	doexe "bin/desktopcouch-service"

	if use doc; then
		insinto "${ROOT}/usr/share/doc/${PF}/api"
		doins "desktopcouch/records/doc/records.txt"
		doins "desktopcouch/records/doc/field_registry.txt"
		doins "desktopcouch/contacts/schema.txt"

		doman "docs/man/desktopcouch-pair.1"
	fi

}
