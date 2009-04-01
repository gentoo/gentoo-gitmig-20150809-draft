# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kaa-base/kaa-base-0.4.0-r1.ebuild,v 1.1 2009/04/01 14:00:43 patrick Exp $

EAPI="2"

inherit python eutils distutils

DESCRIPTION="Basic Framework for all Kaa Python Modules."
HOMEPAGE="http://freevo.sourceforge.net/kaa/"
SRC_URI="mirror://sourceforge/freevo/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="avahi ssl sqlite tls lirc"

DEPEND="dev-lang/python[threads]
	dev-libs/libxml2
	sqlite? ( dev-python/dbus-python >=dev-python/pysqlite-2.2 )
	avahi? ( net-dns/avahi )"
RDEPEND="${DEPEND}
	dev-python/pynotifier
	lirc? ( dev-python/pylirc )
	tls? ( dev-python/tlslite )"

PYTHON_MODNAME="kaa"

src_unpack() {
	distutils_src_unpack

	cd "${S}"
	rm -rf src/notifier/pynotifier
}

pkg_setup() {
	if ! built_with_use dev-libs/libxml2 python; then
		eerror "dev-libs/libxml2 must be built with the 'python' USE flag"
		die "Recompile dev-libs/libxml2 with the 'python' USE flag enabled"
	fi
	if use avahi && ! built_with_use net-dns/avahi python; then
		eerror "net-dns/avahi must be built with the 'python' USE flag"
		die "Recompile net-dns/avahi with the 'python' USE flag enabled"
	fi
}
