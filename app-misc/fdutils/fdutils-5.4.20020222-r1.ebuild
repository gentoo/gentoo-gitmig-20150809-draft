# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/fdutils/fdutils-5.4.20020222-r1.ebuild,v 1.5 2003/02/13 08:56:21 vapier Exp $

DESCRIPTION="The fdutils package contains utilities for configuring and debugging the Linux floppy driver"
SRC_URI="http://fdutils.linux.lu/fdutils-5.4.tar.gz
	 http://fdutils.linux.lu/fdutils-5.4-20020222.diff.gz"
HOMEPAGE="http://fdutils.linux.lu/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=app-admin/mtools-3
	>=app-text/tetex-1.0.7-r10"

S=${WORKDIR}/${PN}-5.4

src_unpack() {
	unpack fdutils-5.4.tar.gz
	gunzip -c ${DISTDIR}/${PN}-5.4-20020222.diff.gz | patch -p0
}

src_compile() {
	econf --enable-fdmount-floppy-only
	make || die
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/man/man1
	dodir /usr/share/man/man4

	einstall

	insinto /etc
	doins src/mediaprm
	dodoc Changelog
}
