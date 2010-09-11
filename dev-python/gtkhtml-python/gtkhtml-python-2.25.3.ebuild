# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/gtkhtml-python/gtkhtml-python-2.25.3.ebuild,v 1.5 2010/09/11 19:02:27 josejx Exp $

EAPI="2"
G_PY_PN="gnome-python-extras"
G_PY_BINDINGS="gtkhtml2"

inherit gnome-python-common

PVP="$(get_version_component_range 1-2)"
SRC_URI="mirror://gnome/sources/${G_PY_PN}/${PVP}/${G_PY_PN}-${PV}.tar.bz2"

DESCRIPTION="A dynamic object module to interface GtkHTML with Python"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE="examples"

RDEPEND="=gnome-extra/gtkhtml-2*"
DEPEND="${RDEPEND}"

EXAMPLES="examples/gtkhtml2/*"
