# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/paxctl/paxctl-0.3-r1.ebuild,v 1.1 2005/06/13 21:29:30 kevquinn Exp $

inherit flag-o-matic eutils

DESCRIPTION="Manages various PaX related program header flags for Elf32, Elf64, binaries."
SRC_URI="http://pax.grsecurity.net/paxctl-${PV}.tar.gz"
HOMEPAGE="http://pax.grsecurity.net"
KEYWORDS="~x86 ~amd64 ~sparc ~ppc ~hppa ~ia64 ~mips ~ppc64"
IUSE=""
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/libc >=sys-devel/binutils-2.14.90.0.8-r1"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-error-codes.patch
}

src_compile() {
	emake CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	einstall DESTDIR="${D}"
	dodoc README ChangeLog
}
