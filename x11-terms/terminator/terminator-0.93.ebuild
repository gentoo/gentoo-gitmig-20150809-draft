# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/terminator/terminator-0.93.ebuild,v 1.3 2010/04/25 11:11:16 jlec Exp $

EAPI="2"

PYTHON_DEPEND="2"
PYTHON_MODNAME="terminatorlib"

inherit distutils eutils

DESCRIPTION="Multiple GNOME terminals in one window"
HOMEPAGE="http://www.tenshu.net/terminator/"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome"

RDEPEND="
	gnome? ( dev-python/gnome-python )
	>=x11-libs/vte-0.16[python]"
DEPEND="dev-util/intltool"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	epatch "${FILESDIR}"/0.90-without-icon-cache.patch
	epatch "${FILESDIR}"/${PV}-session.patch
	distutils_src_prepare
}
