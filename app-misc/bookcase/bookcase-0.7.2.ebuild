# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/bookcase/bookcase-0.7.2.ebuild,v 1.1 2003/11/30 14:23:10 caleb Exp $

inherit kde
need-kde 3

DESCRIPTION="A book manager for the KDE environment"
HOMEPAGE="http://www.periapsis.org/bookcase/"
LICENSE="GPL-2"
SRC_URI="http://www.periapsis.org/bookcase/download/${P}.tar.gz"
IUSE=""
KEYWORDS="x86"

newdepend "dev-libs/libxml2 dev-libs/libxslt"
