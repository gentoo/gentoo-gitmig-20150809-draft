# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/tkman/tkman-2.2.ebuild,v 1.5 2004/04/08 22:59:32 vapier Exp $

inherit eutils

DESCRIPTION="TkMan man and info page browser"
HOMEPAGE="http://tkman.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""

DEPEND=">=app-text/rman-3.1
	>=dev-lang/tcl-8.4
	>=dev-lang/tk-8.4"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	epatch ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
	emake || die
}

src_install() {
	dodir /usr/bin
	make DESTDIR=${D} install || die

	dodoc ANNOUNCE-tkman.txt CHANGES README-tkman manual.html

	insinto /usr/share/icons
	doins contrib/TkMan.gif

	insinto /usr/share/applications
	doins ${FILESDIR}/tkman.desktop
}
