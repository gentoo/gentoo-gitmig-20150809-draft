# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/chpax/chpax-0.4.ebuild,v 1.2 2003/06/02 22:45:31 solar Exp $

S=${WORKDIR}/chpax

DESCRIPTION="Manages various PaX related flags for ELF32, ELF64, and a.out binaries."
SRC_URI="http://pageexec.virtualave.net/chpax-${PV}.tar.gz"
HOMEPAGE="http://pageexec.virtualave.net"
KEYWORDS="x86 ~sparc"
LICENSE="public-domain"
SLOT="0"

IUSE=""
DEPEND="virtual/glibc"

src_compile() {
	mv Makefile{,.orig}        
	sed -e "s|-Wall|${CFLAGS} -Wall|" Makefile.orig > Makefile
	emake CC="${CC}" || die "Parallel Make Failed"
}

src_install() {
	into /
	dosbin chpax
	fperms 700 /sbin/chpax
	dodoc Changelog README
}
