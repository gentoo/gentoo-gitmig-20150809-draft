# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/rolo/rolo-011.ebuild,v 1.8 2004/10/05 13:34:52 pvdabeel Exp $

DESCRIPTION="Text-based contact management software using vCards"
HOMEPAGE="http://rolo.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc alpha"
IUSE=""

DEPEND="dev-libs/libvc
	sys-libs/ncurses"

src_install() {
	emake DESTDIR=${D} install || die
	rm ${D}/usr/share/man/man1/rolo.1 # we will install later via doman
	dodoc AUTHORS INSTALL NEWS README THANKS TODO ChangeLog doc/rfc2426.txt
	doman doc/rolo.1
}
