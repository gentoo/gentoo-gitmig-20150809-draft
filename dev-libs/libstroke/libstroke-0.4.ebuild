# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libstroke/libstroke-0.4.ebuild,v 1.15 2004/03/30 20:52:06 spyderous Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A Stroke and Guesture recognition Library"
SRC_URI="http://www.etla.net/libstroke/${P}.tar.gz"
HOMEPAGE="http://www.etla.net/libstroke"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc alpha ~ppc"

DEPEND=">=sys-libs/glibc-2.1.3
	virtual/x11"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc COPYING COPYRIGHT CREDITS ChangeLog README
}
