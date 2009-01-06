# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/libgksu-python/libgksu-python-2.19.1.ebuild,v 1.2 2009/01/06 14:41:36 neurogeek Exp $

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
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="examples"

RDEPEND=">=x11-libs/libgksu-2.0.4"
DEPEND="${RDEPEND}"

EXAMPLES="examples/gksu2/*"

src_unpack() {
	gnome-python-common_src_unpack

	epatch "${WORKDIR}/${G_PY_PN}-${PV}-split.patch"
	eautoreconf
}
