# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mknbi/mknbi-1.4.0.ebuild,v 1.6 2004/07/15 03:04:35 agriffis Exp $

DESCRIPTION="Utility for making tagged kernel images useful for netbooting"
SRC_URI="mirror://sourceforge/etherboot/${P}.tar.gz"
HOMEPAGE="http://etherboot.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=dev-lang/perl-5.6.1
	dev-lang/nasm"

src_compile()
{
	mv Makefile Makefile.org
	cat Makefile.org | sed s/"\/usr\/local"/"\/usr"/ > Makefile
	emake || die "Compile failed"
}

src_install()
{
	export BUILD_ROOT=${D}
	dodoc COPYING
	make DESTDIR=${D} install || die "Installing failed"
}
