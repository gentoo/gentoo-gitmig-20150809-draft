# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cssc/cssc-0.15_alpha0.ebuild,v 1.3 2004/03/13 01:49:46 mr_bones_ Exp $

MY_P=${P/cssc/CSSC}
MY_P=${MY_P/_alpha/alpha.pl}
S=${WORKDIR}/${MY_P}
DESCRIPTION="CSSC is the GNU Project's replacement for SCCS"
SRC_URI="mirror://sourceforge/cssc/${MY_P}.tar.gz"
HOMEPAGE="http://cssc.sourceforge.net/"
SLOT="0"
LICENSE="GPL-2 LGPL-2"

KEYWORDS="x86"
IUSE=""

DEPEND="virtual/glibc"

src_compile() {
	econf --enable-binary || die
	emake all || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc README NEWS ChangeLog AUTHORS
}

