# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/korelib/korelib-1.0.ebuild,v 1.1 2002/08/20 01:36:25 george Exp $

#A="korelib-1.0.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="theKompany's cross-platform c++ library for developing modular applications"
SRC_URI="ftp://ftp.rygannon.com/pub/Korelib/${P}.tar.gz"
HOMEPAGE="http://www.thekompany.com/projects/korelib/"

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"

LICENSE="GPL-2 | commercial"
SLOT="1"
KEYWORDS="x86"

src_compile() {
	#this is really weird - lib developers did not run automake themselves
	#leaving this to the "end users"
	automake

	./configure \
		--host=${CHOST} --prefix=/usr || die "configure failed"

	emake || die
}

src_install() {
	make DESTDIR=${D} install
	
	#the lib installs one binary with by the name "demo" - baad choice
	mv ${D}/usr/bin/demo ${D}/usr/bin/kore-demo

	dodoc AUTHORS COPYING ChangeLog NEWS README THANKS TODO
}

