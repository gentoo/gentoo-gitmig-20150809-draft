# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libcapsinetwork/libcapsinetwork-0.2.5.ebuild,v 1.1 2004/01/29 22:15:09 mr_bones_ Exp $

inherit flag-o-matic
filter-flags -fomit-frame-pointer

DESCRIPTION="C++ network library to allow fast development of server daemon processes"
HOMEPAGE="http://unixcode.org/libcapsinetwork/"
SRC_URI="http://unixcode.org/downloads/${PN}/${P}.tar.bz2"

KEYWORDS="~x86 ~ppc ~sparc"
LICENSE="LGPL-2.1"
SLOT="1"
IUSE=""

src_compile() {
	econf || die
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
