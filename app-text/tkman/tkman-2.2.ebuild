# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tkman/tkman-2.2.ebuild,v 1.1 2003/12/07 12:39:17 lanius Exp $

DESCRIPTION="TkMan man and info page browser"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://tkman.sourceforge.net/"
KEYWORDS="~x86 ~ppc ~sparc "
SLOT="0"
LICENSE="Artistic"
IUSE=""

DEPEND=">=app-text/rman-3.1
	>=dev-lang/tcl-8.4
	>=dev-lang/tk-8.4"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	patch -p0 <${FILESDIR}/${PF}-gentoo.diff || die
}

src_compile() {
	emake || die
}

src_install () {
	mkdir -p ${D}/usr/bin

	make DESTDIR=${D} install || die

	dodoc ANNOUNCE-tkman.txt CHANGES README-tkman manual.html

	insinto /usr/share/icons
	doins contrib/TkMan.gif

	insinto /usr/share/applications
	doins ${FILESDIR}/tkman.desktop
}
