# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/chpax/chpax-0.6.ebuild,v 1.1 2003/12/30 21:26:08 solar Exp $

inherit flag-o-matic

DESCRIPTION="Manages various PaX related flags for ELF32, ELF64, and a.out binaries."
SRC_URI="http://pageexec.virtualave.net/chpax-${PV}.tar.gz"
HOMEPAGE="http://pageexec.virtualave.net"
KEYWORDS="~x86 ~amd64 ~sparc ~ppc ~hppa ~ia64 ~mips"
LICENSE="public-domain"
SLOT="0"

#IUSE="static"
DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s|-Wall|${CFLAGS}|" Makefile
}

src_compile() {
	# breaks with current ssp.
	# use static && append-ldflags -static

	emake CC="${CC}" TARGET="chpax ${LDFLAGS:0}" || die "Parallel Make Failed"
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
