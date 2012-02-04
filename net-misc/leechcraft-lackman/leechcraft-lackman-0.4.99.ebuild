# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/leechcraft-lackman/leechcraft-lackman-0.4.99.ebuild,v 1.2 2012/02/04 19:16:16 ago Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="LeechCraft Package Manager for extensions, scripts, themes etc."

SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}
		>=x11-libs/qt-webkit-4.6"
RDEPEND="${DEPEND}
		virtual/leechcraft-downloader-http"
