# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/bookcase/bookcase-0.6.4.ebuild,v 1.3 2004/05/01 12:05:46 centic Exp $

inherit kde-base
need-kde 3

DESCRIPTION="A book manager for the KDE environment"
HOMEPAGE="http://www.periapsis.org/bookcase/"
SRC_URI="http://www.periapsis.org/bookcase/download/${P}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"

IUSE=""
SLOT="0"

DEPEND="dev-libs/libxml2
	>=dev-libs/libxslt-1.0.19"

