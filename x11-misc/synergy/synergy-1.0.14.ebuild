# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/synergy/synergy-1.0.14.ebuild,v 1.5 2004/04/03 06:48:32 pylon Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Lets you easily share a single mouse and keyboard between multiple computers."
SRC_URI="mirror://sourceforge/${PN}2/${P}.tar.gz"
HOMEPAGE="http://synergy2.sourceforge.net/"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ppc"
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
