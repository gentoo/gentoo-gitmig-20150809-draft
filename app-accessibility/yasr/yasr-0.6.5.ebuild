# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/yasr/yasr-0.6.5.ebuild,v 1.2 2004/03/17 23:05:34 dholm Exp $

DESCRIPTION="Yasr is a general-purpose console screen reader for GNU/Linux and other Unix-like operating systems."
HOMEPAGE="http://yasr.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="virtual/glibc
	>=sys-devel/make-3.80
	>=sys-devel/autoconf-2.58"

src_compile() {
	econf datadir='/etc' || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README ChangeLog COPYING ABOUT-NLS AUTHORS BUGS CREDITS INSTALL
}

