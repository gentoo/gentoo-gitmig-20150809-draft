# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdbakeoven/cdbakeoven-2.0_beta2.ebuild,v 1.6 2003/06/28 01:37:08 msterret Exp $

inherit kde-base

need-kde 3

IUSE=""
MY_P=${P/_/}
DESCRIPTION="CDBakeOven, KDE CD Writing Software"
SRC_URI="mirror://sourceforge/cdbakeoven/${MY_P}.tar.bz2"
S=${WORKDIR}/${MY_P}
HOMEPAGE="http://cdbakeoven.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="x86 ppc ~sparc"

newdepend ">=media-libs/libogg-1.0_rc2
	>=media-sound/mpg123-0.59
	>=media-sound/cdparanoia-3.9.8
	>=app-cdr/cdrtools-1.11
	>=kde-base/kdemultimedia-3.1.1"
