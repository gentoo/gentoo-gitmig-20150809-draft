# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libcapsinetwork/libcapsinetwork-0.1.1.ebuild,v 1.1 2002/08/01 14:54:19 bass Exp $
inherit flag-o-matic

DESCRIPTION="libCapsiNetwork is a C++ network library to allow fast development of server daemon processes."
HOMEPAGE="http://sourceforge.net/projects/libcapsinetwork/"
SRC_URI="mirror://sourceforge//libcapsinetwork/${P}.tar.bz2"
LICENSE="GPL"
SLOT="1"
KEYWORDS="x86"

DEPEND=""
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}

filter-flags "-fomit-frame-pointer"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
}
