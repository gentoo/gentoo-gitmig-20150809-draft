# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/comedi/comedi-0.7.67.ebuild,v 1.1 2003/11/20 19:34:16 caleb Exp $

inherit kernel-mod

DESCRIPTION="Comedi - COntrol and MEasurement Device Interface for Linux"
SRC_URI="ftp://ftp.comedi.org/pub/comedi/${P}.tar.gz"
HOMEPAGE="http://www.comedi.org"
KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"

src_compile()
{
	kernel-mod_getversion
	./configure --prefix=${D}/usr --with-linuxdir=${KERNEL_DIR}
	emake
}

src_install()
{
	make install
}
