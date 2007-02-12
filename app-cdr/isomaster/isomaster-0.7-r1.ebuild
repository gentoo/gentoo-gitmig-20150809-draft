# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/isomaster/isomaster-0.7-r1.ebuild,v 1.2 2007/02/12 23:19:17 peper Exp $

inherit eutils

DESCRIPTION="GTK2 (bootable) CD ISO Image editor."
HOMEPAGE="http://littlesvr.ca/isomaster/"
SRC_URI="http://littlesvr.ca/isomaster/releases/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.0"
DEPEND="${RDEPEND}"

src_compile() {
	# make flags useful
	sed -i -e "s:-Wall:${CFLAGS}:" Makefile || die "sed failed"
	sed -i -e "s:-Wall:${CFLAGS}:" */Makefile || die "sed failed"

	emake PREFIX="/usr" -j1 || die "emake failed"
}

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" install || die "Install failed"
	dodoc *.TXT bk/TODO.TXT

	doicon icons/${PN}.png
	make_desktop_entry ${PN} "Isomaster" ${PN}.png "Application;AudioVideo;"
}

