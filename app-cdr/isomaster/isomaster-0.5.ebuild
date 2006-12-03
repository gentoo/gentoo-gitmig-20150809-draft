# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/isomaster/isomaster-0.5.ebuild,v 1.1 2006/12/03 05:55:55 pylon Exp $

DESCRIPTION="GTK2 (bootable) CD ISO Image editor."
HOMEPAGE="http://littlesvr.ca/isomaster/"
SRC_URI="http://littlesvr.ca/isomaster/releases/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~x86"

SLOT="0"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.0"

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" install || die "Install failed"

	cd ${S}
	dodoc *.TXT bk/TODO.TXT
}

