# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/krename/krename-3.0.0_rc3.ebuild,v 1.3 2004/06/30 13:20:57 agriffis Exp $

inherit kde

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="KRename - a very powerful batch file renamer"
HOMEPAGE="http://www.krename.net/"
SRC_URI="mirror://sourceforge/krename/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE="debug"

need-kde 3.1

src_compile() {
		use debug || myconf="${myconf} --enable-final"
		kde_src_compile
}
