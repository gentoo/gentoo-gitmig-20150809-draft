# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/uudeview/uudeview-0.5.18.ebuild,v 1.8 2003/08/25 03:19:31 msterret Exp $

DESCRIPTION="uu, xx, base64, binhex decoder"
HOMEPAGE="http://www.fpx.de/fp/Software/UUDeview/"
SRC_URI="http://www.fpx.de/fp/Software/UUDeview/download/${P}.tar.gz"

KEYWORDS="x86 ~sparc"
LICENSE="GPL-2"
SLOT="0"

IUSE="tcltk debug"

DEPEND="tcltk? ( dev-lang/tcl dev-lang/tk )"

src_compile() {
	econf \
		`use_enable tcltk tcl` \
		`use_enable tcltk tk` \
		`use_enable debug optimize` \
		|| die
	emake || die "emake failed"
}

src_install() {
	einstall MANDIR=${D}/usr/share/man/ || die
	dodoc HISTORY INSTALL README
}
