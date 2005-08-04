# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/kpl/kpl-3.2.ebuild,v 1.3 2005/08/04 08:52:41 greg_g Exp $

inherit kde

DESCRIPTION="KDE tool for plotting data sets and functions in 2D and 3D."
HOMEPAGE="http://frsl06.physik.uni-freiburg.de/privat/stille/kpl/"
SRC_URI="http://frsl06.physik.uni-freiburg.de/privat/stille/kpl/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

need-kde 3.2
