# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tcllib/tcllib-1.6.1-r1.ebuild,v 1.1 2005/05/17 13:55:38 matsuu Exp $

inherit eutils

DESCRIPTION="Tcl Standard Library."
HOMEPAGE="http://www.tcl.tk/software/tcllib/"
SRC_URI="mirror://sourceforge/tcllib/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
IUSE=""
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~amd64 ~ia64 ~s390"

DEPEND=">=dev-lang/tcl-8.3.1"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-fr.msg.patch
}

src_compile() {
	econf || die
	# emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc ChangeLog PACKAGES* README STATUS *.txt
}
