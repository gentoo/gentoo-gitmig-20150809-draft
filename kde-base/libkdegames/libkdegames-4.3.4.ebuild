# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdegames/libkdegames-4.3.4.ebuild,v 1.1 2009/12/01 11:19:42 wired Exp $

EAPI="2"

KMNAME="kdegames"
inherit kde4-meta

DESCRIPTION="Base library common to many KDE games."
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug"

DEPEND="
	>=dev-games/ggz-client-libs-0.0.14
"
RDEPEND="${DEPEND}"

KMSAVELIBS="true"
