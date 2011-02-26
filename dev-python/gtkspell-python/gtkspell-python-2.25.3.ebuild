# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gtkspell-python/gtkspell-python-2.25.3.ebuild,v 1.8 2011/02/26 13:22:16 eva Exp $

EAPI="2"
G_PY_PN="gnome-python-extras"
SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.*"

inherit gnome-python-common

PVP="$(get_version_component_range 1-2)"
SRC_URI="mirror://gnome/sources/${G_PY_PN}/${PVP}/${G_PY_PN}-${PV}.tar.bz2"

DESCRIPTION="GtkSpell bindings for Python"
# The LICENSE with gtkspell-3 is LGPL and there is no way to express this in
# an ebuild, currently. Punt till we actually have to face the issue.
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="doc examples"

RDEPEND="=app-text/gtkspell-2*"
DEPEND="${RDEPEND}"

EXAMPLES="examples/gtkspell/*"
