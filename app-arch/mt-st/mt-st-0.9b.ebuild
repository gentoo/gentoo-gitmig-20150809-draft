# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/mt-st/mt-st-0.9b.ebuild,v 1.11 2009/10/12 16:43:45 halcy0n Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Enhanced mt command for Linux, supporting Linux 2.4 ioctls"
HOMEPAGE="http://www.gnu.org/software/tar/"
SRC_URI="http://www.ibiblio.org/pub/linux/system/backup/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A} || die
	cd "${S}" || die
	sed -i -e "s:-O2:${CFLAGS}:g" Makefile

	# needed for linux kernels >=2.6.20
	epatch "${FILESDIR}"/${P}-use-internal-qic117.patch
}

src_compile() {
	# Builds straight from .c to final binary
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS} ${LDFLAGS}" || die
}

src_install() {
	dosbin mt stinit || die
	doman mt.1 stinit.8
	dodoc README* stinit.def.examples
}
