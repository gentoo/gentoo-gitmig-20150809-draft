# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gtkguitune/gtkguitune-0.7-r1.ebuild,v 1.2 2007/08/19 15:30:09 drac Exp $

inherit eutils

DESCRIPTION="A guitar tuning program that uses Schmitt-triggering for quick feedback."
HOMEPAGE="http://www.geocities.com/harpin_floh/kguitune_page.html"
SRC_URI="http://www.geocities.com/harpin_floh/mysoft/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc amd64"
IUSE=""

RDEPEND="=x11-libs/gtk+-1.2*
	=dev-cpp/gtkmm-1.2*"
DEPEND="${RDEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc README AUTHORS
	doicon *.xpm
	make_desktop_entry ${PN} "Guitune" guitune_logo.xpm
}
