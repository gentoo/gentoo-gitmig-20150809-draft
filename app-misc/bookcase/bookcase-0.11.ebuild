# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/bookcase/bookcase-0.11.ebuild,v 1.1 2004/09/13 19:11:43 carlo Exp $

inherit kde eutils

DESCRIPTION="A book manager for the KDE environment"
HOMEPAGE="http://www.periapsis.org/bookcase/"
SRC_URI="http://www.periapsis.org/bookcase/download/${P}.tar.gz"

KEYWORDS="~x86"
LICENSE="GPL-2"

IUSE=""
SLOT="0"

DEPEND=">=dev-libs/libxml2-2.4.23
	>=dev-libs/libxslt-1.0.19
	kde-base/kdemultimedia"
need-kde 3.1
