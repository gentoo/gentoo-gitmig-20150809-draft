# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kubrick/kubrick-4.9.1.ebuild,v 1.1 2012/09/04 18:45:25 johu Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdegames"
KDE_SCM="svn"
OPENGL_REQUIRED="always"
inherit kde4-meta

DESCRIPTION="KDE: Kubrick is a game based on \"Rubik's Cube\" puzzle."
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"
