# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/katalog/katalog-0.3.ebuild,v 1.1 2004/11/08 19:12:19 motaboy Exp $

inherit kde


DESCRIPTION="Integrated cataloger for KDE"
SRC_URI="http://salvaste.altervista.org/${P}.tar.gz"
HOMEPAGE="http://salvaste.altervista.org/"

LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

need-kde 3.2
need-qt 3.1