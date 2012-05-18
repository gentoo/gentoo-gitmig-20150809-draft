# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmines/kmines-4.8.3.ebuild,v 1.3 2012/05/18 20:13:34 ago Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdegames"
KDE_SELINUX_MODULE="games"
inherit kde4-meta

DESCRIPTION="KMines is a classic mine sweeper game"
KEYWORDS="amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"
