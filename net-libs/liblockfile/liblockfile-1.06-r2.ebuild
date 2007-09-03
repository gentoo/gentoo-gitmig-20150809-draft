# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/liblockfile/liblockfile-1.06-r2.ebuild,v 1.11 2007/09/03 11:33:14 uberlord Exp $

inherit eutils multilib flag-o-matic autotools

DESCRIPTION="Implements functions designed to lock the standard mailboxes"
HOMEPAGE="http://www.debian.org/"
SRC_URI="mirror://debian/pool/main/libl/${PN}/${PN}_${PV}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-glibc24.patch
	epatch "${FILESDIR}"/${P}-respectflags.patch
	epatch "${FILESDIR}"/${PN}-orphan-file.patch

	# Rename an internal function so it does not conflict with
	# libc's function.
	sed -i -e 's/eaccess/egidaccess/g' *.c

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
	emake ROOT="${D}" install || die
}
