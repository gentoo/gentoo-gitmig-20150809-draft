# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/aterm/aterm-1.6.7.ebuild,v 1.3 2003/01/21 02:50:56 nall Exp $

S=${WORKDIR}/${P}
DESCRIPTION="ATerm tree-handling library"
SRC_URI="http://www.cwi.nl/projects/MetaEnv/aterm/${P}.tar.gz"
HOMEPAGE="http://www.cwi.nl/projects/MetaEnv/aterm/"
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ~ppc"
DEPEND="java? ( virtual/jdk )"
IUSE="java"

src_compile() {
	local myconf
	use java && myconf="${myconf} --with-java"
	
	econf \
		--with-gcc \
		${myconf} || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS COPYING ChangeLog NEWS README
}
