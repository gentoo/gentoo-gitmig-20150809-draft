# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/digitaldj/digitaldj-0.7.3.ebuild,v 1.1 2003/06/17 12:38:16 twp Exp $

DESCRIPTION="A SQL-based mp3-player frontend designed to work with Grip"
HOMEPAGE="http://www.nostatic.org/ddj/"
SRC_URI="http://www.nostatic.org/ddj/${P}.tar.gz"
LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~alpha ~arm ~hppa ~mips ~sparc ~x86"
IUSE=""
DEPEND="dev-db/mysql
	gnome-base/libghttp
	media-libs/gdk-pixbuf
	media-sound/grip
	>=x11-libs/gtk+-1.2"

src_compile() {
	econf --disable-lirc
	emake || die
}

src_install() {
	einstall
	dodoc AUTHORS ChangeLog README
}
