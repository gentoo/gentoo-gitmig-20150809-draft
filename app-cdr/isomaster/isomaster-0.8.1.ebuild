# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/isomaster/isomaster-0.8.1.ebuild,v 1.2 2007/05/19 16:41:16 welp Exp $

inherit eutils

DESCRIPTION="GTK2 (bootable) CD ISO Image editor."
HOMEPAGE="http://littlesvr.ca/isomaster/"
SRC_URI="http://littlesvr.ca/isomaster/releases/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
SLOT="0"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.0"
DEPEND="${RDEPEND}"

src_compile() {
	emake PREFIX="/usr" || die "emake failed"
}

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" install || die "Install failed"
	dodoc *.TXT bk/TODO.TXT

	doicon icons/${PN}.png
	make_desktop_entry ${PN} "Isomaster" ${PN}.png "Application;AudioVideo;"
}

