# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xpad/xpad-1.13.ebuild,v 1.8 2004/04/13 07:53:22 mr_bones_ Exp $

DESCRIPTION="A GTK+ 2.0 based 'post-it' note system."
HOMEPAGE="http://xpad.sourceforge.net/"
SRC_URI="mirror://sourceforge/xpad/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ppc"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.0.0"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e 's:-Wall\\:-Wall:' \
		-e '/DISABLE_DEPRECATED/d' src/Makefile.in \
			|| die "sed failed"
}

src_install () {
	einstall || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
