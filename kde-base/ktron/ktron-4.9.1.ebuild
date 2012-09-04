# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ktron/ktron-4.9.1.ebuild,v 1.1 2012/09/04 18:45:47 johu Exp $

EAPI=4

KMNAME="kdegames"
KDE_SCM="svn"
KDE_SELINUX_MODULE="games"
inherit kde4-meta

DESCRIPTION="KDE Tron game"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"
