# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xpad/xpad-1.11.ebuild,v 1.5 2004/01/25 14:29:23 tseng Exp $

IUSE="nls"

DESCRIPTION="A GTK+ 2.0 based 'post-it' note system."
HOMEPAGE="http://xpad.sourceforge.net/"
SRC_URI="mirror://sourceforge/xpad/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ~ppc"

DEPEND=">=x11-libs/gtk+-2.0.0
		nls? ( sys-devel/gettext )"

src_compile () {
	econf `use_enable nls` || die
	emake || die
}

src_install () {
	einstall || die
	dodoc AUTHORS ChangeLog COPYING NEWS README TODO
}
