# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/liblockfile/liblockfile-1.03-r1.ebuild,v 1.12 2004/07/16 03:04:24 tgall Exp $

IUSE=

inherit eutils gcc

DESCRIPTION="Implements functions designed to lock the standard mailboxes."
SRC_URI="mirror://debian/pool/main/libl/${PN}/${PN}_${PV}.tar.gz"
HOMEPAGE="http://www.debian.org"

DEPEND="virtual/libc"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 ppc sparc alpha hppa ia64 amd64 ~mips ppc64"
IUSE=""

src_unpack() {
	unpack ${A}

	if [ "`gcc-major-version`" -gt 3 ] || \
	   [ "`gcc-major-version`" -eq 3 -a "`gcc-minor-version`" -ge 3 ]
	then
		cd ${S}; epatch ${FILESDIR}/${P}-gcc33.patch
	fi
}

src_compile() {

	econf --with-mailgroup=mail || die
	emake || die
}

src_install() {

	dodir /usr/{bin,include,lib} /usr/share/man/{man1,man3}
	make  ROOT=${D} install || die
}
