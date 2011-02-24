# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/brasero-python/brasero-python-2.32.0.ebuild,v 1.3 2011/02/24 18:42:59 tomka Exp $

EAPI="3"
GCONF_DEBUG="no"
G_PY_PN="gnome-python-desktop"
G_PY_BINDINGS="braseroburn braseromedia"

inherit gnome-python-common

DESCRIPTION="Python bindings for Brasero CD/DVD burning"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc x86 ~x86-fbsd"
IUSE="examples"

RDEPEND=">=app-cdr/brasero-2.29
	!<dev-python/gnome-python-desktop-2.22.0-r10"
DEPEND="${RDEPEND}"

EXAMPLES="examples/braseroburn/*
	examples/braseromedia/*"
