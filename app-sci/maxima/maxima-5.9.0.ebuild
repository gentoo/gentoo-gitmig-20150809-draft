# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/maxima/maxima-5.9.0.ebuild,v 1.2 2003/04/19 20:16:51 george Exp $

DESCRIPTION="Free computer algebra environment, based on Macsyma"
HOMEPAGE="http://maxima.sourceforge.net/"
SRC_URI="http://dl.sourceforge.net/sourceforge/maxima/maxima-${PV}.tar.gz"

LICENSE="GPL-2 AECA"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE=""
DEPEND=">=dev-lisp/clisp-2.29
		>=sys-apps/texinfo-4.3"
RDEPEND=">=dev-lang/tk-8.3.3"

S=${WORKDIR}/${P}

src_compile() {
	econf
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	#move docs to the appropriate place
	dodoc AUTHORS ChangeLog COPYING COPYING1 NEWS README*
	mv ${D}/usr/share/${PN}/${PV}/doc/* ${D}/usr/share/doc/${PF}/
}
