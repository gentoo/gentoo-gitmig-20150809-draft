# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/bookcase/bookcase-0.6.4.ebuild,v 1.1 2003/09/08 17:42:27 avenj Exp $

inherit kde-base

need-kde 3

DESCRIPTION="A book manager for the KDE environment"
HOMEPAGE="http://www.periapsis.org/bookcase/"
LICENSE="GPL-2"
SRC_URI="http://www.periapsis.org/bookcase/download/${P}.tar.gz"
IUSE=""
KEYWORDS="~x86"

DEPEND="dev-libs/libxml2
	>=dev-libs/libxslt-1.0.19"
