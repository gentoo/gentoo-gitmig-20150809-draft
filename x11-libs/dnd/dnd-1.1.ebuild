# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/dnd/dnd-1.1.ebuild,v 1.12 2004/02/16 22:25:54 agriffis Exp $

S=${WORKDIR}/DND/DNDlib
DESCRIPTION="OffiX' Drag'n'drop library"
HOMEPAGE="http://leb.net/OffiX"
SRC_URI="http://leb.net/OffiX/dnd.1.1.tgz"

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="x86 sparc alpha ia64"

DEPEND="virtual/x11"

src_unpack() {
	unpack dnd.1.1.tgz
	cd ${S}
	epatch ${FILESDIR}/${PF}-gentoo.diff || die
}

src_compile() {
	econf --with-x || die
	emake || die
}

src_install () {
	make prefix=${D}/usr install || die
}
