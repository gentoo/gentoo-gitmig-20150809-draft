# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gdl-python/gdl-python-2.25.3.ebuild,v 1.9 2011/02/26 19:22:50 eva Exp $

EAPI="2"
G_PY_PN="gnome-python-extras"

SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.*"

inherit gnome-python-common

PVP="$(get_version_component_range 1-2)"
SRC_URI="mirror://gnome/sources/${G_PY_PN}/${PVP}/${G_PY_PN}-${PV}.tar.bz2"

DESCRIPTION="Python bindings for GDL"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="examples"

RDEPEND=">=dev-libs/gdl-2.28:1"
DEPEND="${RDEPEND}"

EXAMPLES="examples/gdl/*"

src_prepare() {
	# Fix build failure with gdl-2.28
	epatch "${FILESDIR}/${PN}-2.19.1-gdlapi-removal.patch"

	gnome-python-common_src_prepare
}
