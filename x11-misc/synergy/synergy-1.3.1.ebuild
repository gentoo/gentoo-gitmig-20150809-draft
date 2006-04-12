# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/synergy/synergy-1.3.1.ebuild,v 1.1 2006/04/12 16:25:07 nakano Exp $

inherit eutils

DESCRIPTION="Lets you easily share a single mouse and keyboard between multiple computers."
SRC_URI="mirror://sourceforge/${PN}2/${P}.tar.gz"
HOMEPAGE="http://synergy2.sourceforge.net/"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
SLOT="0"
IUSE=""

RDEPEND="|| ( (
		x11-libs/libXtst
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXinerama )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( (
		x11-proto/xextproto
		x11-proto/xproto
		x11-proto/kbproto
		x11-proto/xineramaproto
		x11-libs/libXt )
	virtual/x11 )"

src_compile() {
	econf --sysconfdir=/etc || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS ChangeLog HISTORY NEWS PORTING README TODO
	insinto /etc
	doins ${S}/examples/synergy.conf
}

pkg_postinst() {
	einfo
	einfo "${PN} can also be used to connect to computers running Windows."
	einfo "Visit ${HOMEPAGE} to find the Windows client."
	einfo
}
