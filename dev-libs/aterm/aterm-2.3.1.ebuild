# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/aterm/aterm-2.3.1.ebuild,v 1.3 2005/12/26 19:48:38 weeve Exp $

DESCRIPTION="ATerm tree-handling library"
HOMEPAGE="http://www.cwi.nl/projects/MetaEnv/aterm/"
SRC_URI="http://www.cwi.nl/projects/MetaEnv/aterm/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~ppc sparc x86"
IUSE="java"

DEPEND="java? ( virtual/jdk )"

src_compile() {
	local myc
	use java && myc="--with-java" || myc="--without-java"

	# 2004-06-11: karltk
	# May want to add 64bit support on some archs?
	# Cannot do --without-64bit on 32bit arch
	econf \
		--with-gcc \
		--with-cflags="${CFLAGS}" \
		--without-dbg \
		--with-prof \
		${myconf} || die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog NEWS README
}
