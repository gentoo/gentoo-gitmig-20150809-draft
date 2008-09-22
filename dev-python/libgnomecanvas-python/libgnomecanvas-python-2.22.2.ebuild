# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/libgnomecanvas-python/libgnomecanvas-python-2.22.2.ebuild,v 1.1 2008/09/22 08:05:55 leio Exp $

G_PY_PN="gnome-python"
G_PY_BINDINGS="gnomecanvas"

inherit gnome-python-common

DESCRIPTION="Python bindings for the Gnome Canvas library"
LICENSE="LGPL-2.1"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="examples"

RDEPEND=">=gnome-base/libgnomecanvas-2.8
	!<dev-python/gnome-python-2.22.1"
DEPEND="${RDEPEND}"

EXAMPLES="examples/canvas/*"
