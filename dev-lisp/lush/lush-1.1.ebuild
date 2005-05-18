# Copyright 1999-2005 Gentoo Foundation and Matthew Kennedy <mkennedy@gentoo.org>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/lush/lush-1.1.ebuild,v 1.1 2005/05/18 08:23:03 mkennedy Exp $

DESCRIPTION="Lush is the Lisp User Shell"
HOMEPAGE="http://lush.sourceforge.net/"
SRC_URI="mirror://sourceforge/lush/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="X"

DEPEND="X? ( virtual/x11 )"

src_compile() {
	econf `use_with X X` || die "./configure failed"
	emake -j1 || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc 0-CVS-INFO COPYING COPYRIGHT \
		README README.binutils README.cygwin README.mac
}
