# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-wm/selectwm/selectwm-0.3-r1.ebuild,v 1.1 2002/09/01 15:25:18 seemant Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="window manager selector tool"
HOMEPAGE="http://ordiluc.net/selectwm"
SRC_URI="http://ordiluc.net/selectwm/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND="=x11-libs/gtk+-1.2*
	>=dev-libs/glib-1.2.0"

src_compile() {
	local myconf
	use nls || myconf="--disable-nls"

	econf ${myconf} || die
	emake || die
}

src_install () {
	einstall || die
	dodoc AUTHORS ChangeLog COPYING NEWS README
}
