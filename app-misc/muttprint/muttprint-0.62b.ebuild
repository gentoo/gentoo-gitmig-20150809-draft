# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/muttprint/muttprint-0.62b.ebuild,v 1.1 2002/07/28 12:18:51 aliz Exp $

DESCRIPTION="pretty printing of your mails"
HOMEPAGE="http://muttprint.sf.net"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/muttprint/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="app-text/tetex"
RDEPEND=$DEPEND

S=${WORKDIR}/${P}

src_install () {
	# understanding the install part of the Makefiles.
	make prefix=${D}/usr docdir=${D}/${prefix}/doc/ install || die
}

