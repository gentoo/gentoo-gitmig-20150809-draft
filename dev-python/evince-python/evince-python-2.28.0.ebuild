# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/evince-python/evince-python-2.28.0.ebuild,v 1.4 2010/05/22 15:58:01 armin76 Exp $

GCONF_DEBUG="no"
G_PY_PN="gnome-python-desktop"

inherit gnome-python-common

DESCRIPTION="Python bindings for the libwnck library"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc x86"
IUSE=""

RDEPEND=">=app-text/evince-2.25
	!<dev-python/gnome-python-desktop-2.22.0-r10"
DEPEND="${RDEPEND}"
