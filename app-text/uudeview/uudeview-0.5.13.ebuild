# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/uudeview/uudeview-0.5.13.ebuild,v 1.14 2004/03/12 09:18:44 mr_bones_ Exp $

DESCRIPTION="uu, xx, base64, binhex decoder"
HOMEPAGE="http://www.fpx.de/fp/Software/UUDeview/"
SRC_URI="http://ibiblio.org/pub/Linux/utils/text/${P}.tar.gz"

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
