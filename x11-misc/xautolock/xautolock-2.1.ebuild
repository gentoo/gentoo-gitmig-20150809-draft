# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xautolock/xautolock-2.1.ebuild,v 1.6 2002/10/04 06:43:53 vapier Exp $

DESCRIPTION="An automatic X screen-locker/screen-saver."
SRC_URI="http://www.ibiblio.org/pub/Linux/X11/screensavers/${P}.tgz"
HOMEPAGE="http://www.ibiblio.org/pub/Linux/X11/screensavers/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/x11"

src_compile() {
	xmkmf || die
	emake || die
}

src_install () {
	into /usr
	dobin xautolock || die
	newman xautolock.man xautolock.1
	dodoc Changelog Readme Todo
}
