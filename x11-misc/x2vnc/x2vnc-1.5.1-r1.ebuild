# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/x2vnc/x2vnc-1.5.1-r1.ebuild,v 1.4 2004/01/05 13:01:55 weeve Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Control a remote computer running VNC from X"
SRC_URI="http://www.hubbe.net/~hubbe/${P}.tar.gz"
HOMEPAGE="http://www.hubbe.net/~hubbe/x2vnc.html"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~alpha sparc"

DEPEND="virtual/x11
	tcltk? ( dev-tcltk/expect )
	>=sys-apps/sed-4"

IUSE="tcltk"

src_compile() {
	econf
	emake || die "make failed"
}

src_install () {

	sed -i -e 's/$(\(...\)DIR)/$(DESTDIR)\/$(\1DIR)/
			   s/\(^INSTALL.*\)/\1 -D/' Makefile
	make DESTDIR=${D} install || die

	if [ `use tcltk` ]
	then
		dobin contrib/tkx2vnc
	fi

	dodoc ChangeLog README
}


