# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/fdutils/fdutils-5.4.20020222-r1.ebuild,v 1.13 2004/06/14 09:14:13 kloeri Exp $

inherit eutils

S=${WORKDIR}/${PN}-5.4
DESCRIPTION="utilities for configuring and debugging the Linux floppy driver"
HOMEPAGE="http://fdutils.linux.lu/"
SRC_URI="http://fdutils.linux.lu/${PN}-5.4.tar.gz
	 http://fdutils.linux.lu/${PN}-5.4-20020222.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=sys-fs/mtools-3
	tetex? ( virtual/tetex )"

src_unpack() {
	unpack ${A}
	epatch ${WORKDIR}/${PN}-5.4-20020222.diff

	# the man 4 fd manpage is better in the man-pages package, so stop it
	# from installing
	epatch ${FILESDIR}/${PN}-no-fd.4-manpage.diff
}

src_compile() {
	econf --enable-fdmount-floppy-only || die

	if use tetex
	then
		make || die
	else
		make compile || die
	fi
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/man/man1

	einstall || die

	insinto /etc
	doins src/mediaprm
	dodoc Changelog
}
