# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/chpax/chpax-0.5.ebuild,v 1.9 2004/06/28 16:01:35 vapier Exp $

# S=${WORKDIR}/chpax
DESCRIPTION="Manages various PaX related flags for ELF32, ELF64, and a.out binaries."
HOMEPAGE="http://pageexec.virtualave.net/"
SRC_URI="http://pageexec.virtualave.net/chpax-${PV}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 ppc sparc ~hppa ~amd64 ia64"
IUSE=""

DEPEND="virtual/libc"

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
