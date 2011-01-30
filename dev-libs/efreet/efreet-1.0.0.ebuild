# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/efreet/efreet-1.0.0.ebuild,v 1.1 2011/01/30 14:59:11 tommy Exp $

inherit enlightenment

DESCRIPTION="library for handling of freedesktop.org specs (desktop/icon/theme/etc...)"
SRC_URI="http://download.enlightenment.org/releases/${P}.tar.bz2"

KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

RDEPEND=">=dev-libs/ecore-1.0.0_beta
	>=dev-libs/eina-1.0.0_beta
	x11-misc/xdg-utils"
DEPEND="${RDEPEND}"
