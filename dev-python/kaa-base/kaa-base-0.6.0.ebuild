# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kaa-base/kaa-base-0.6.0.ebuild,v 1.2 2009/11/19 09:22:08 volkmar Exp $

EAPI="2"

NEED_PYTHON="2.5"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="Basic Framework for all Kaa Python Modules."
HOMEPAGE="http://freevo.sourceforge.net/kaa/"
SRC_URI="mirror://sourceforge/freevo/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ppc ~x86"
IUSE="avahi ssl sqlite tls lirc"

DEPEND="dev-lang/python[threads]
	>=dev-libs/glib-2.4.0
	>=dev-libs/libxml2-2.6.0[python]
	sqlite? ( dev-python/dbus-python >=dev-python/pysqlite-2.3.0 )
	avahi? ( net-dns/avahi[python] )"
RDEPEND="${DEPEND}
	dev-python/pynotifier
	lirc? ( dev-python/pylirc )
	tls? ( dev-python/tlslite )"

RESTRICT_PYTHON_ABIS="2.4 3*"

PYTHON_MODNAME="kaa"

src_prepare() {
	distutils_src_prepare

	rm -fr src/pynotifier
}
