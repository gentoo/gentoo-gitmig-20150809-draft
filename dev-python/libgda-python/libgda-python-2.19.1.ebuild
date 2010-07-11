# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/libgda-python/libgda-python-2.19.1.ebuild,v 1.10 2010/07/11 15:14:35 pacho Exp $

EAPI="2"
G_PY_PN="gnome-python-extras"
G_PY_BINDINGS="gda"

inherit gnome-python-common

PVP="$(get_version_component_range 1-2)"
SRC_URI="mirror://gnome/sources/${G_PY_PN}/${PVP}/${G_PY_PN}-${PV}.tar.bz2
	mirror://gentoo/${G_PY_PN}-${PV}-split.patch.gz"

DESCRIPTION="Python bindings for interacting with libgda"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="=gnome-extra/libgda-3*
	>=dev-python/libbonobo-python-2.22.1"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${WORKDIR}/${G_PY_PN}-${PV}-split.patch"
	eautoreconf

	gnome-python-common_src_prepare
}
