# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gtkguitune/gtkguitune-0.6.ebuild,v 1.7 2004/07/13 07:33:55 eradicator Exp $

IUSE=""

LICENSE="GPL-2"
KEYWORDS="x86 ~sparc ~amd64"
DESCRIPTION="Guitune is a linux program for tuning guitars and other instruments by using the method of Schmitt-triggering."
SRC_URI="http://www.geocities.com/harpin_floh/mysoft/${P}.tar.gz"
HOMEPAGE="http://www.geocities.com/harpin_floh/kguitune_page.html"
SLOT="0"

DEPEND="=x11-libs/gtk+-1.2*
	=dev-cpp/gtkmm-1.2*"

src_install() {
	einstall || die
	dodoc README AUTHORS
}
