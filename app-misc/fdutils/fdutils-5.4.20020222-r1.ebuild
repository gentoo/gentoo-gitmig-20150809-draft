# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/fdutils/fdutils-5.4.20020222-r1.ebuild,v 1.6 2003/04/12 09:37:10 seemant Exp $

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
	
	local myconf="src doc info"

	use tetex && myconf="${myconf} html dvi"

	econf --enable-fdmount-floppy-only || die
	make ${myconf} || die
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
