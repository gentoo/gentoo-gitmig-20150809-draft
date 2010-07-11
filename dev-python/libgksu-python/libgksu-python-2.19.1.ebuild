# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/libgksu-python/libgksu-python-2.19.1.ebuild,v 1.11 2010/07/11 15:15:41 pacho Exp $

EAPI="2"
# The 'gksu' and 'gksuui' bindings are not supported. We don't have =libgksu-1*
# in tree.
G_PY_PN="gnome-python-extras"
G_PY_BINDINGS="gksu2"

inherit gnome-python-common

PVP="$(get_version_component_range 1-2)"
SRC_URI="mirror://gnome/sources/${G_PY_PN}/${PVP}/${G_PY_PN}-${PV}.tar.bz2
	mirror://gentoo/${G_PY_PN}-${PV}-split.patch.gz"

DESCRIPTION="Python bindings for libgksu"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="examples"

RDEPEND=">=x11-libs/libgksu-2.0.4"
DEPEND="${RDEPEND}"

EXAMPLES="examples/gksu2/*"

src_prepare() {
	epatch "${WORKDIR}/${G_PY_PN}-${PV}-split.patch"
	eautoreconf

	gnome-python-common_src_prepare
}
