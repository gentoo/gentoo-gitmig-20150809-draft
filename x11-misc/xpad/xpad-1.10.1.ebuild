# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xpad/xpad-1.10.1.ebuild,v 1.2 2003/05/10 23:33:34 liquidx Exp $

IUSE=""

DESCRIPTION="A GTK+ 2.0 based 'post-it' note system."
HOMEPAGE="http://xpad.sourceforge.net/"
SRC_URI="mirror://sourceforge/xpad/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"

DEPEND=">=x11-libs/gtk+-2.0.0"

src_install () {
	make DESTDIR=${D} install || die "Installation failed"
	dodoc CHANGES COPYING README TODO
}
