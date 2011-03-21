# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/metacity-python/metacity-python-2.32.0.ebuild,v 1.6 2011/03/21 21:12:12 xarthisius Exp $

EAPI="3"
GCONF_DEBUG="no"
G_PY_PN="gnome-python-desktop"
SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.*"

inherit gnome-python-common

DESCRIPTION="Python bindings for the Metacity window manager"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ~ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-wm/metacity-2.21.5
	!<dev-python/gnome-python-desktop-2.22.0-r10"
DEPEND="${RDEPEND}"
