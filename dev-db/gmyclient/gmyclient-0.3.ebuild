# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/gmyclient/gmyclient-0.3.ebuild,v 1.10 2004/11/21 20:50:46 dragonheart Exp $

DESCRIPTION="Gnome based mysql client"
SRC_URI="http://${PN}.sourceforge.net/download/${P}.tar.gz"
HOMEPAGE="http://gmyclient.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE="nls"

DEPEND=">=gnome-base/gnome-libs-1.2
		>=dev-db/mysql-3
		=gnome-base/libglade-0*"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-fix.patch
}

src_compile() {
	econf `use_enable nls` || die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die "installed failed"
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
	mv ${D}/usr/share/gmyclient/doc ${D}/usr/share/doc/${PF}/html
}
