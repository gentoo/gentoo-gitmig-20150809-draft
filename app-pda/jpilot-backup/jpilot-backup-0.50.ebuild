# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/jpilot-backup/jpilot-backup-0.50.ebuild,v 1.1 2004/07/05 15:54:02 agriffis Exp $

DESCRIPTION="Backup plugin for jpilot"
SRC_URI="http://jasonday.home.att.net/code/backup/${P}.tar.gz"
HOMEPAGE="http://jasonday.home.att.net/code/backup/backup.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~alpha"
IUSE="nls gtk2"

RDEPEND="gtk2? ( >=x11-libs/gtk+-2 )
	!gtk2? ( >=x11-libs/gtk+-1.2 )
	app-pda/jpilot"
DEPEND="${RDEPEND}
	gtk2? ( dev-util/pkgconfig )"

src_compile() {
	econf $(use_enable gtk2) || die "configure failed"
	emake -j1 || die "make failed"
}

src_install() {
	make install DESTDIR=${D} || die
}
