# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/fdutils/fdutils-5.4.20020222-r1.ebuild,v 1.7 2003/04/12 10:11:33 seemant Exp $

S=${WORKDIR}/${PN}-5.4
DESCRIPTION="The fdutils package contains utilities for configuring and debugging the Linux floppy driver"
HOMEPAGE="http://fdutils.linux.lu/"
SRC_URI="http://fdutils.linux.lu/${PN}-5.4.tar.gz
	 http://fdutils.linux.lu/${PN}-5.4-20020222.diff.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=app-admin/mtools-3
	tetex? ( >=app-text/tetex-1.0.7-r10 )"

src_unpack() {
	unpack ${A}
	epatch ${WORKDIR}/${PN}-5.4-20020222.diff
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
	dodir /usr/share/man/man4

	einstall || die

	insinto /etc
	doins src/mediaprm
	dodoc Changelog
}
