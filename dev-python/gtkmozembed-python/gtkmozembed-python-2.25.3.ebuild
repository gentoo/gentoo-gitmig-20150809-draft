# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gtkmozembed-python/gtkmozembed-python-2.25.3.ebuild,v 1.9 2011/03/24 11:08:09 ssuominen Exp $

EAPI="2"
G_PY_PN="gnome-python-extras"
SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.*"

inherit confutils gnome-python-common

PVP="$(get_version_component_range 1-2)"
SRC_URI="mirror://gnome/sources/${G_PY_PN}/${PVP}/${G_PY_PN}-${PV}.tar.bz2"

DESCRIPTION="Python bindings for the GtkMozEmbed Gecko library"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="doc"

RDEPEND=">=net-libs/xulrunner-1.9:1.9"
DEPEND="${RDEPEND}"

pkg_setup() {
	gnome-python-common_pkg_setup

	G2CONF="${G2CONF} --with-gtkmozembed=xulrunner-1.9"
}

src_prepare() {
	# Accomodate new releases of libtool
	epatch "${FILESDIR}/${PN}-2.19.1-libtool2.patch"

	# Allow building with xulrunner 1.9, bug #
	rm "${S}/gtkmozembed/gtkmozembedmodule.c"
	epatch "${FILESDIR}/${P}-xulrunner19.patch"

	# Fix building with xulrunner-1.9.2, bug 296924
	epatch "${FILESDIR}/${PN}-2.19.1-include-nspr.patch"

	eautoreconf
	gnome-python-common_src_prepare
}
