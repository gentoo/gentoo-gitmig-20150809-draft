# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/jpilot-backup/jpilot-backup-0.50.ebuild,v 1.10 2006/08/29 04:29:48 chriswhite Exp $

DESCRIPTION="Backup plugin for jpilot"
SRC_URI="http://jasonday.home.att.net/code/backup/${P}.tar.gz"
HOMEPAGE="http://jasonday.home.att.net/code/backup/backup.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ~ppc x86"
IUSE="gtk"

RDEPEND="gtk? ( >=x11-libs/gtk+-2 )
	app-pda/jpilot
	sys-libs/gdbm"
DEPEND="${RDEPEND}
	gtk? ( dev-util/pkgconfig )"

src_compile() {
	econf $(use_enable gtk gtk2) || die "configure failed"
	emake -j1 || die "make failed"
}

src_install() {
	make install DESTDIR=${D} || die
}
