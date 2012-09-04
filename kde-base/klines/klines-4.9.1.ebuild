# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/klines/klines-4.9.1.ebuild,v 1.1 2012/09/04 18:45:40 johu Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdegames"
KDE_SCM="svn"
KDE_SELINUX_MODULE="games"
inherit kde4-meta

DESCRIPTION="KDE: Kolor Lines - a little game about balls and how to get rid of them"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"
