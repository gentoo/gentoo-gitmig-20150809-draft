# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/telepathy-butterfly/telepathy-butterfly-0.5.15.ebuild,v 1.4 2011/02/07 19:43:51 arfrever Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2:2.5"
RESTRICT_PYTHON_ABIS="2.4 3.*"
PYTHON_EXPORT_PHASE_FUNCTIONS="1"

inherit python multilib

DESCRIPTION="An MSN connection manager for Telepathy"
HOMEPAGE="http://telepathy.freedesktop.org/releases/telepathy-butterfly/"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-python/telepathy-python-0.15.17
	>=dev-python/papyon-0.5.1
	>=net-libs/libproxy-0.3.1[python]"

DOCS="AUTHORS NEWS"

src_prepare() {
	# disable pyc compiling
	mv py-compile py-compile-disabled
	ln -s $(type -P true) py-compile

	python_copy_sources
}

pkg_postinst() {
	python_mod_optimize butterfly
}

pkg_postrm() {
	python_mod_cleanup butterfly
}
