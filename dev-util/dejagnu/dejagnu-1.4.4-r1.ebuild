# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/dejagnu/dejagnu-1.4.4-r1.ebuild,v 1.7 2004/11/10 01:53:24 vapier Exp $

inherit eutils

DESCRIPTION="framework for testing other programs"
HOMEPAGE="http://www.gnu.org/software/dejagnu/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sparc x86"
IUSE="doc"

DEPEND="virtual/libc
	dev-lang/tcl
	dev-tcltk/expect"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/dejagnu-ignore-libwarning.patch
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README TODO
	use doc && dohtml -r doc/html/
}
