# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/knutclient/knutclient-0.7.1.ebuild,v 1.5 2004/07/15 02:56:18 agriffis Exp $

inherit kde

DESCRIPTION="Client for the NUT UPS monitoring daemon"
SRC_URI="ftp://ftp.buzuluk.cz/pub/alo/knutclient/${P}.tar.gz"
HOMEPAGE="http://www.alo.cz/knutclient-pop-en.html"
KEYWORDS="~x86 ~sparc"
IUSE=""
LICENSE="GPL-2"
SLOT="0"

RDEPEND=">=x11-libs/qt-2.3.0"

src_compile() {
	econf || die
	emake || die
}

src_install() {

	# Makefile: user/group nut might not exist until after
	# pkg_preinst() runs; so use root for now, and fix it
	# up in pkg_postinst().
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog INSTALL README TODO
}
