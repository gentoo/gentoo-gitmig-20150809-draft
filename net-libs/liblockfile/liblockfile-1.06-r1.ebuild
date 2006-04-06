# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/liblockfile/liblockfile-1.06-r1.ebuild,v 1.2 2006/04/06 00:54:50 langthang Exp $

inherit eutils multilib flag-o-matic autotools

DESCRIPTION="Implements functions designed to lock the standard mailboxes."
SRC_URI="mirror://debian/pool/main/libl/${PN}/${PN}_${PV}.tar.gz"
HOMEPAGE="http://www.debian.org"

DEPEND="virtual/libc"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}/${P}-glibc24.patch"
	epatch "${FILESDIR}/${P}-respectflags.patch"

	eautoreconf

	# Do not use lazy bindings on setXid files
	sed -i -e 's~-o dotlockfile~'$(bindnow-flags)' &~g' Makefile.in
}

src_compile() {
	econf --with-mailgroup=mail --enable-shared || die
	emake || die
}

src_install() {
	dodir /usr/{bin,include,$(get_libdir)} /usr/share/man/{man1,man3}
	make ROOT=${D} install || die
}
