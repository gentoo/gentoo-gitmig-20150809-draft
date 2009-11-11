# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/kpl/kpl-3.3.ebuild,v 1.6 2009/11/11 12:32:18 ssuominen Exp $

ARTS_REQUIRED=never
inherit kde

DESCRIPTION="KDE tool for plotting data sets and functions in 2D and 3D."
HOMEPAGE="http://frsl06.physik.uni-freiburg.de/privat/stille/kpl/"
SRC_URI="http://frsl06.physik.uni-freiburg.de/privat/stille/kpl/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ~ppc ppc64 x86"
IUSE=""

need-kde 3.5

PATCHES=( "${FILESDIR}/${PN}-3.2-arts-configure.patch" )
