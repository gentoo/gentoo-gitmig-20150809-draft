# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/yudit/yudit-2.7.5.ebuild,v 1.1 2003/08/24 12:43:33 mholzer Exp $

DESCRIPTION="free (Y)unicode text editor for all unices"
SRC_URI="http://yudit.org/download/${P}.tar.bz2"
HOMEPAGE="http://www.yudit.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"

DEPEND="virtual/x11 
	>=sys-devel/gettext-0.10"

src_compile() {
	econf || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
}
