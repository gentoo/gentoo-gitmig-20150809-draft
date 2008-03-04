# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdegames/libkdegames-4.0.1.ebuild,v 1.2 2008/03/04 04:33:16 jer Exp $

EAPI="1"

KMNAME=kdegames
KMNODOCS=true
inherit kde4-meta

DESCRIPTION="Base library common to many KDE games."
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="debug"

DEPEND=">=dev-games/ggz-client-libs-0.0.14"
RDEPEND="${DEPEND}"

RESTRICT="test"
