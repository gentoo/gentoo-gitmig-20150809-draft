# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gdl-python/gdl-python-2.19.1-r1.ebuild,v 1.5 2009/01/06 23:36:42 neurogeek Exp $

G_PY_PN="gnome-python-extras"

inherit gnome-python-common

PVP="$(get_version_component_range 1-2)"
SRC_URI="mirror://gnome/sources/${G_PY_PN}/${PVP}/${G_PY_PN}-${PV}.tar.bz2
	mirror://gentoo/${G_PY_PN}-${PV}-split.patch.gz"

DESCRIPTION="Python bindings for GDL"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="examples"

RDEPEND=">=dev-libs/gdl-2.24.0"
DEPEND="${RDEPEND}"

EXAMPLES="examples/gdl/*"

pkg_setup() {
	# we need gdl-gnome
	if ! built_with_use --missing true dev-libs/gdl gnome; then
		eerror "If you want to build ${PN} you need to build dev-libs/gdl with"
		eerror "the the 'gnome' USE flag."
		die "gdl must be built with USE='gnome'"
	fi

	gnome-python-common_pkg_setup
}

src_unpack() {
	gnome-python-common_src_unpack

	epatch "${WORKDIR}/${G_PY_PN}-${PV}-split.patch"
	eautoreconf

	# Fix build failure with recent gdl
	epatch "${FILESDIR}/${P}-gdlicons.patch"
}
