# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/krename/krename-3.0.0_rc2.ebuild,v 1.1 2004/05/25 23:56:11 caleb Exp $

inherit kde
need-kde 3.1

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="KRename - a very powerful batch file renamer"
HOMEPAGE="http://www.krename.net/"
SRC_URI="mirror://sourceforge/krename/${MY_P}.tar.bz2"
SLOT="0"

LICENSE="GPL-2"
KEYWORDS="~x86"

IUSE=""

src_compile() {
		myconf="${myconf} --enable-final"
		kde_src_compile
}
