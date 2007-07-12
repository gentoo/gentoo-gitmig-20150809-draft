# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cssc/cssc-0.15_alpha0.ebuild,v 1.7 2007/07/12 01:05:41 mr_bones_ Exp $

MY_P=${P/cssc/CSSC}
MY_P=${MY_P/_alpha/alpha.pl}
S=${WORKDIR}/${MY_P}
DESCRIPTION="CSSC is the GNU Project's replacement for SCCS"
SRC_URI="mirror://sourceforge/cssc/${MY_P}.tar.gz"
HOMEPAGE="http://cssc.sourceforge.net/"
SLOT="0"
LICENSE="GPL-2 LGPL-2"

KEYWORDS="x86 ~amd64"
IUSE=""

DEPEND="virtual/libc"

src_compile() {
	econf --enable-binary || die
	emake all || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc README NEWS ChangeLog AUTHORS
}
