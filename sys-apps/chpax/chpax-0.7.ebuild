# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/chpax/chpax-0.7.ebuild,v 1.7 2004/10/28 20:31:27 solar Exp $

inherit flag-o-matic toolchain-funcs

DESCRIPTION="Manages various PaX related flags for ELF32, ELF64, and a.out binaries."
HOMEPAGE="http://pax.grsecurity.net/"
SRC_URI="http://pax.grsecurity.net/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 ppc ~ppc64 sparc ~mips ~alpha ~arm hppa amd64 ~ia64"
IUSE=""

RDEPEND="virtual/libc"
DEPEND="${RDEPEND} >=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s|-Wall|${CFLAGS}|" Makefile
}

src_compile() {
	# use static && append-ldflags -static	; # breaks with current ssp.
	emake CC="$(tc-getCC)" TARGET="chpax ${LDFLAGS:0}" || die "Parallel Make Failed"
}

src_install() {
	into /
	dosbin chpax || die
	fperms 711 /sbin/chpax

	dodoc Changelog README
	doman chpax.1

	insinto /etc/conf.d
	newins ${FILESDIR}/pax-conf.d chpax
	exeinto /etc/init.d
	newexe ${FILESDIR}/pax-init.d chpax
}
