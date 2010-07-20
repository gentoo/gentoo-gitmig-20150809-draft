# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/libgksu-python/libgksu-python-2.25.3.ebuild,v 1.2 2010/07/20 16:40:55 jer Exp $

EAPI="2"
# The 'gksu' and 'gksuui' bindings are not supported. We don't have =libgksu-1*
# in tree.
G_PY_PN="gnome-python-extras"
G_PY_BINDINGS="gksu2"

inherit gnome-python-common

PVP="$(get_version_component_range 1-2)"
SRC_URI="mirror://gnome/sources/${G_PY_PN}/${PVP}/${G_PY_PN}-${PV}.tar.bz2"

DESCRIPTION="Python bindings for libgksu"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="examples"

RDEPEND=">=x11-libs/libgksu-2.0.4"
DEPEND="${RDEPEND}"

EXAMPLES="examples/gksu2/*"
