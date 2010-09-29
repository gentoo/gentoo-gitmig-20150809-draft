# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/telepathy-butterfly/telepathy-butterfly-0.5.14.ebuild,v 1.1 2010/09/29 10:32:33 pacho Exp $

EAPI="2"
PYTHON_DEPEND="2:2.5"

inherit python multilib eutils

DESCRIPTION="An MSN connection manager for Telepathy"
HOMEPAGE="http://telepathy.freedesktop.org/releases/telepathy-butterfly/"
SRC_URI="http://telepathy.freedesktop.org/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc64 ~sparc ~x86"
IUSE="libproxy"

RDEPEND=">=dev-python/telepathy-python-0.15.17
	>=dev-python/papyon-0.5.1
	libproxy? ( >=net-libs/libproxy-0.3.1[python] )"

DOCS="AUTHORS NEWS"

src_prepare() {
	# disable pyc compiling
	mv py-compile py-compile-disabled
	ln -s $(type -P true) py-compile
}

src_install() {
	emake install DESTDIR="${D}"
}
