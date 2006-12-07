# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fluxconf/fluxconf-0.9.8.ebuild,v 1.9 2006/12/07 02:14:13 flameeyes Exp $

IUSE=""

DESCRIPTION="Configuration editor for fluxbox"
SRC_URI="http://devaux.fabien.free.fr/flux/${P}.tar.gz"
HOMEPAGE="http://devaux.fabien.free.fr/flux/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86 ~x86-fbsd"

DEPEND="=x11-libs/gtk+-1.2*"

src_install () {
	einstall || die
	rm "${D}"/usr/bin/fluxkeys "${D}"/usr/bin/fluxmenu

	dosym /usr/bin/fluxconf /usr/bin/fluxkeys
	dosym /usr/bin/fluxconf /usr/bin/fluxmenu
	dosym /usr/bin/fluxconf /usr/bin/fluxbare

	dodoc AUTHORS COPYING ChangeLog NEWS README
}
