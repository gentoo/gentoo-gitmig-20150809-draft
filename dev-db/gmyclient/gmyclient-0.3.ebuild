# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/gmyclient/gmyclient-0.3.ebuild,v 1.5 2003/07/11 21:04:12 aliz Exp $

DESCRIPTION="Gnome based mysql client"
SRC_URI="http://${PN}.sourceforge.net/download/${P}.tar.gz"
HOMEPAGE="http://gmyclient.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE="nls"

DEPEND=">=gnome-base/gnome-libs-1.2
		>=dev-db/mysql-3 "

src_compile() {
	econf `use_enable nls`
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die "installed failed"
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
	mv ${D}/usr/share/gmyclient/doc ${D}/usr/share/doc/${PF}/html

}
