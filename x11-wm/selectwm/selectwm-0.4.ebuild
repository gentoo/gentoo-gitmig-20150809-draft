# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/selectwm/selectwm-0.4.ebuild,v 1.6 2003/02/13 17:54:39 vapier Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="window manager selector tool"
HOMEPAGE="http://ordiluc.net/selectwm"
SRC_URI="http://ordiluc.net/selectwm/${P}.tar.bz2"
IUSE="nls"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="x86 sparc ~ppc"

DEPEND=">=x11-libs/gtk+-2.0.0
	>=dev-libs/glib-2.0.0"

src_compile() {
	local myconf

	use nls || myconf="--disable-nls"

	econf \
		--program-suffix=2 \
		${myconf} || die
	emake || die
}

src_install () {
	einstall || die
	dodoc AUTHORS ChangeLog COPYING NEWS README
}
