# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/uudeview/uudeview-0.5.18.ebuild,v 1.7 2003/08/01 20:48:14 vapier Exp $

DESCRIPTION="uu, xx, base64, binhex decoder"
HOMEPAGE="http://www.fpx.de/fp/Software/UUDeview/"
SRC_URI="http://www.fpx.de/fp/Software/UUDeview/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc"
IUSE="tcltk debug"

DEPEND="tcltk? ( dev-lang/tcl dev-lang/tk )"

src_compile() {
	econf \
		`use_enable tcltk tcl` \
		`use_enable tcltk tk` \
		`use_enable debug optimize` \
		|| die
	make || die
}

src_install() {
	einstall MANDIR=${D}/usr/share/man/ || die
	dodoc COPYING INSTALL README
}
