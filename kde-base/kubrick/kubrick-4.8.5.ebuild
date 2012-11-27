# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kubrick/kubrick-4.8.5.ebuild,v 1.5 2012/11/27 15:20:25 kensington Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdegames"
OPENGL_REQUIRED="always"
inherit kde4-meta

DESCRIPTION="A game based on the \"Rubik's Cube\" puzzle."
KEYWORDS="amd64 ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="virtual/glu"
DEPEND="${RDEPEND}
	virtual/opengl
"
