# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/fribidi/fribidi-0.10.4.ebuild,v 1.1 2003/03/31 22:59:03 foser Exp $

DESCRIPTION="A free implementation of the unicode bidirectional algorithm"

HOMEPAGE="http://fribidi.sourceforge.net/"
SRC_URI="mirror://sourceforge/fribidi/${P}.tar.bz2"
LICENSE="LGPL-2.1"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/glibc"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die

	dodoc COPYRIGHT AUTHORS NEWS README ChangeLog \
		INSTALL THANKS TODO ANNOUNCE COPYING
}

