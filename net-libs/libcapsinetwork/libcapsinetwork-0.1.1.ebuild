# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libcapsinetwork/libcapsinetwork-0.1.1.ebuild,v 1.10 2004/01/29 22:15:09 mr_bones_ Exp $

inherit flag-o-matic
filter-flags -fomit-frame-pointer

DESCRIPTION="C++ network library to allow fast development of server daemon processes"
HOMEPAGE="http://sourceforge.net/projects/libcapsinetwork/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="x86 ppc sparc"

DEPEND=""

src_compile() {
	econf || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
}
