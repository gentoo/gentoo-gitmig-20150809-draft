# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/liblockfile/liblockfile-1.03-r1.ebuild,v 1.3 2003/09/06 22:04:23 msterret Exp $

IUSE=

inherit eutils gcc

S="${WORKDIR}/${P}"
DESCRIPTION="Implements functions designed to lock the standard mailboxes."
SRC_URI="ftp://ftp.debian.org/debian/pool/main/libl/${PN}/${PN}_${PV}.tar.gz"
HOMEPAGE="http://www.debian.org"

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 ppc sparc alpha hppa"

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

