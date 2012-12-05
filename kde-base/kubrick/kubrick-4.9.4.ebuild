# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kubrick/kubrick-4.9.4.ebuild,v 1.1 2012/12/05 16:57:40 alexxy Exp $

EAPI=4

if [[ ${PV} == *9999 ]]; then
	eclass="kde4-base"
else
	eclass="kde4-meta"
	KMNAME="kdegames"
fi
KDE_HANDBOOK="optional"
OPENGL_REQUIRED="always"
inherit ${eclass}

DESCRIPTION="A game based on the \"Rubik's Cube\" puzzle."
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="$(add_kdebase_dep libkdegames)
	virtual/glu
"
DEPEND="${RDEPEND}
	virtual/opengl
"
