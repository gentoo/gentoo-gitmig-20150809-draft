# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/egg-python/egg-python-2.25.3.ebuild,v 1.7 2011/01/30 18:19:11 armin76 Exp $

EAPI="2"

# We don't support the egg.recent bindings that are also provided - they are
# deprecated, have deps we don't really want and there are no users in-tree.
G_PY_PN="gnome-python-extras"
G_PY_BINDINGS="eggtray"

inherit gnome-python-common

PVP="$(get_version_component_range 1-2)"
SRC_URI="mirror://gnome/sources/${G_PY_PN}/${PVP}/${G_PY_PN}-${PV}.tar.bz2"

DESCRIPTION="EggTrayIcon bindings for Python"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="examples"

RDEPEND=">=dev-python/libbonobo-python-2.22.1
	>=dev-python/libgnome-python-2.22.1"
DEPEND="${RDEPEND}"

EXAMPLES="examples/egg/tray*"
