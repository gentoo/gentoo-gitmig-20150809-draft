# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/muttprint/muttprint-0.63a.ebuild,v 1.3 2003/06/29 23:17:15 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="pretty printing of your mails"
HOMEPAGE="http://muttprint.sf.net/"
SRC_URI="mirror://sourceforge/muttprint/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="app-text/tetex"

src_install() {
	# understanding the install part of the Makefiles.
	make prefix=${D}/usr docdir=${D}/usr/share/doc/ install || die
}
