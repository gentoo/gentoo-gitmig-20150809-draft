# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-misc/synergy/synergy-1.0.8.ebuild,v 1.1 2003/05/15 07:36:32 utx Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Lets you easily share a single mouse and keyboard between multiple computers."
SRC_URI="mirror://sourceforge/${PN}2/${P}.tar.gz"
HOMEPAGE="http://synergy2.sourceforge.net/"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"
SLOT="0"
IUSE=""

DEPEND="virtual/x11"

src_compile() {

	econf --sysconfdir=/etc || die
	emake || die
	
}

src_install () {

	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS COPYING ChangeLog HISTORY NEWS PORTING README TODO
	insinto /etc
	doins ${S}/examples/synergy.conf
}

pkg_postinst() {
	einfo
	einfo "${PN} can also be used to connect to computers running Windows."
	einfo "Visit ${HOMEPAGE} to find the Windows client."
	einfo
}
