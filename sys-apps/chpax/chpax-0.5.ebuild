# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/chpax/chpax-0.5.ebuild,v 1.6 2004/01/02 08:43:29 solar Exp $

# S=${WORKDIR}/chpax

DESCRIPTION="Manages various PaX related flags for ELF32, ELF64, and a.out binaries."
SRC_URI="http://pageexec.virtualave.net/chpax-${PV}.tar.gz"
HOMEPAGE="http://pageexec.virtualave.net"
KEYWORDS="x86 ~amd64 sparc ~ppc ~hppa ia64"
LICENSE="public-domain"
SLOT="0"

IUSE=""
DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	mv Makefile{,.orig}
	sed -e "s|-Wall|${CFLAGS} -Wall|" Makefile.orig > Makefile
}

src_compile() {
	emake CC="${CC}" || die "Parallel Make Failed"
}

src_install() {
	into /
	dosbin chpax
	fperms 711 /sbin/chpax

	dodoc Changelog README
	doman chpax.1

	insinto /etc/conf.d
	newins ${FILESDIR}/pax-conf.d chpax
	exeinto /etc/init.d
	newexe ${FILESDIR}/pax-init.d chpax

}
