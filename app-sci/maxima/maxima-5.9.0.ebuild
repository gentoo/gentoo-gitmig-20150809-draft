# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/maxima/maxima-5.9.0.ebuild,v 1.5 2003/11/18 16:13:37 vapier Exp $

DESCRIPTION="Free computer algebra environment, based on Macsyma"
HOMEPAGE="http://maxima.sourceforge.net/"
SRC_URI="mirror://sourceforge/maxima/maxima-${PV}.tar.gz"

LICENSE="GPL-2 AECA"
SLOT="0"
KEYWORDS="x86 ~ppc"

DEPEND=">=dev-lisp/clisp-2.29
	>=sys-apps/texinfo-4.3"
RDEPEND=">=dev-lang/tk-8.3.3"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	#move docs to the appropriate place
	dodoc AUTHORS ChangeLog COPYING COPYING1 NEWS README*
	mv ${D}/usr/share/${PN}/${PV}/doc/* ${D}/usr/share/doc/${PF}/
}
