# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lineakd/lineakd-0.6_alpha2.ebuild,v 1.2 2003/09/05 23:18:18 msterret Exp $

IUSE="nls xosd"

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}
DESCRIPTION=" Linux support for Easy Access and Internet Keyboards features X11 support"
HOMEPAGE="http://lineak.sourceforge.net/"
SRC_URI="mirror://sourceforge/lineak/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND=">=sys-apps/portage-2.0.47-r10
	virtual/x11
	xosd? ( x11-libs/xosd )
	nls? ( sys-devel/gettext )"

src_compile() {
	econf `use_enable nls` `use_with xosd` --with-x || die
	emake || die
}

src_install () {
	make DESTDIR=${D} lineakddocdir=/usr/share/doc/${P} install || die
	dodoc AUTHORS COPYING INSTALL README TODO
}
