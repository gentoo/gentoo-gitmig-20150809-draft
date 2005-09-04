# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gtkguitune/gtkguitune-0.7.ebuild,v 1.5 2005/09/04 11:01:18 flameeyes Exp $

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc amd64"
DESCRIPTION="A guitar tuning program that uses Schmitt-triggering for quick feedback."
SRC_URI="http://www.geocities.com/harpin_floh/mysoft/${P}.tar.gz"
HOMEPAGE="http://www.geocities.com/harpin_floh/kguitune_page.html"
SLOT="0"

IUSE=""

DEPEND="=x11-libs/gtk+-1.2*
	=dev-cpp/gtkmm-1.2*"

src_install() {
	einstall || die
	dodoc README AUTHORS
	insinto /usr/share/pixmaps
	doins *.xpm
}
