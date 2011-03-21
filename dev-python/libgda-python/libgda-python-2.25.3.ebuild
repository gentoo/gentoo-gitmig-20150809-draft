# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/libgda-python/libgda-python-2.25.3.ebuild,v 1.9 2011/03/21 21:06:36 nirbheek Exp $

EAPI="2"
G_PY_PN="gnome-python-extras"
G_PY_BINDINGS="gda"

SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.*"

inherit gnome-python-common

PVP="$(get_version_component_range 1-2)"
SRC_URI="mirror://gnome/sources/${G_PY_PN}/${PVP}/${G_PY_PN}-${PV}.tar.bz2"

DESCRIPTION="Python bindings for interacting with libgda"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=gnome-extra/libgda-4:4
	>=dev-python/libbonobo-python-2.22.1:2"
DEPEND="${RDEPEND}"
