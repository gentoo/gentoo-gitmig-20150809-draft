# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libcapsinetwork/libcapsinetwork-0.2.5.ebuild,v 1.2 2004/04/18 20:21:32 vapier Exp $

inherit flag-o-matic

DESCRIPTION="C++ network library to allow fast development of server daemon processes"
HOMEPAGE="http://unixcode.org/libcapsinetwork/"
SRC_URI="http://unixcode.org/downloads/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

src_compile() {
	filter-flags -fomit-frame-pointer
	econf || die
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
