# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libstroke/libstroke-0.4.ebuild,v 1.7 2002/08/14 11:52:27 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A Stroke and Guesture recognition Library"
SRC_URI="http://www.etla.net/libstroke/${P}.tar.gz"
HOMEPAGE="http://www.etla.net/libstroke"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND=">=sys-libs/glibc-2.1.3
	>=x11-base/xfree-4.0.3"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc COPYING COPYRIGHT CREDITS ChangeLog README 
}
