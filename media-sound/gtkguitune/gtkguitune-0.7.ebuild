# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gtkguitune/gtkguitune-0.7.ebuild,v 1.1 2004/07/23 06:07:10 chriswhite Exp $

LICENSE="GPL-2"
KEYWORDS="~x86"
DESCRIPTION="A guitar tuning program that uses Schmitt-triggering for quick feedback."
SRC_URI="http://www.geocities.com/harpin_floh/mysoft/${P}.tar.gz"
HOMEPAGE="http://www.geocities.com/harpin_floh/kguitune_page.html"
SLOT="0"

IUSE=""

DEPEND="=x11-libs/gtk+-1.2*
	=dev-cpp/gtkmm-1.2*"

src_compile() {
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	einstall || die
	dodoc README AUTHORS COPYING
	insinto /usr/share/pixmaps
	doins *.xpm
}
