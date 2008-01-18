# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdegames/libkdegames-4.0.0.ebuild,v 1.1 2008/01/18 01:30:07 ingmar Exp $

EAPI="1"

KMNAME=kdegames
KMNODOCS=true
inherit kde4-meta

DESCRIPTION="Base library common to many KDE games."
KEYWORDS="~amd64 ~x86"
IUSE="debug "
RESTRICT="test"
