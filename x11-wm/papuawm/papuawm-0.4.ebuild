# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/papuawm/papuawm-0.4.ebuild,v 1.4 2005/03/28 11:07:24 usata Exp $

DESCRIPTION="PapuaWM, a minimalistic, though useable window manager"
MY_P="${P/papuawm/PapuaWM}"
S=${WORKDIR}/${MY_P}
SRC_URI="http://www.daimi.au.dk/~pg/papuawm/${MY_P}.tar.gz"

HOMEPAGE="http://papuaos.org/papuawm"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~sparc"
IUSE=""

DEPEND="virtual/x11"

src_compile() {
	econf --x-libraries=/usr/X11R6/lib || die
	emake || die
}

src_install () {
	einstall
	dodoc README STATUS TODO papuawm.conf ChangeLog
}
