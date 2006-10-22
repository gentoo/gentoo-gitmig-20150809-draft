# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/supervise-scripts/supervise-scripts-3.5.ebuild,v 1.4 2006/10/22 06:34:45 vapier Exp $

inherit fixheadtails toolchain-funcs

DESCRIPTION="Starting and stopping daemontools managed services"
HOMEPAGE="http://untroubled.org/supervise-scripts/"
SRC_URI="http://untroubled.org/supervise-scripts/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE=""

RDEPEND=">=sys-process/daemontools-0.70"
DEPEND="${RDEPEND}
	dev-libs/bglibs"

src_unpack() {
	unpack ${A}
	cd "${S}"
	echo '/usr/bin' > conf-bin
	echo '/usr/lib/bglibs/lib' > conf-bglibs
	echo '/usr/lib/bglibs/include' > conf-bgincs
	echo "$(tc-getCC) ${CFLAGS}" > conf-cc
	echo "$(tc-getCC) ${LDFLAGS}" > conf-ld
	ht_fix_file svscan-add-to-inittab.in Makefile
}

src_compile() {
	# does NOT support parallel make
	emake -j1 || die
}

src_install() {
	dobin svc-add svc-isdown svc-isup svc-remove \
		svc-start svc-status svc-stop svc-restart \
		svc-waitdown svc-waitup svscan-add-to-inittab \
		svscan-add-to-inittab svscan-start svscan-stopall \
		|| die
	dodoc ANNOUNCEMENT ChangeLog NEWS README TODO VERSION
	doman *.[0-9]
}
