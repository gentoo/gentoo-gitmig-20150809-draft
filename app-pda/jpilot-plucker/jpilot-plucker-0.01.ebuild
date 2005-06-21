# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/jpilot-plucker/jpilot-plucker-0.01.ebuild,v 1.5 2005/06/21 02:32:55 agriffis Exp $

DESCRIPTION="Plucker plugin for jpilot"
SRC_URI="http://jasonday.home.att.net/code/jpilot-plucker/${P}.tar.gz"
HOMEPAGE="http://jasonday.home.att.net/code/jpilot-plucker/jpilot-plucker.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ~ppc x86"
IUSE="gtk2"

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
