# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/comedi/comedi-0.7.68.ebuild,v 1.1 2004/03/01 15:48:00 caleb Exp $

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

	addpredict ${KERNEL_DIR}

	# The stuff below is taken from the kernel's Makefile.  The problem here is that
	# we need the ARCH variable to be set to what the kernel is expecting, but the Gento
	# build system overrides it, so we'll force it to what the kernel wants for the 
	# compilation phase.

	LOCALARCH=$(uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ \
		-e s/arm.*/arm/ -e s/sa110/arm/ \
		-e s/s390x/s390/ -e s/parisc64/parisc/ )

	ARCH=${LOCALARCH} ./configure --prefix=${D}/usr --libdir=${D}/lib --with-linuxdir=${KERNEL_DIR}
	emake
}

src_install()
{
	make install
}
