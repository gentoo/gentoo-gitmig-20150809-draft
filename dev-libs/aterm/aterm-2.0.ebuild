# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/aterm/aterm-2.0.ebuild,v 1.1 2004/02/17 20:36:38 karltk Exp $

DESCRIPTION="ATerm tree-handling library"
HOMEPAGE="http://www.cwi.nl/projects/MetaEnv/aterm/"
SRC_URI="http://www.cwi.nl/projects/MetaEnv/aterm/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE="java"

DEPEND="java? ( virtual/jdk )"

src_compile() {
	local myc
	use java && myc="--with-java" || myc="--without-java"

	# 2004-02-07: karltk
	# May want to add 64bit support on some archs?
	# Cannot explicitly disable features with --without, it blows up.
	econf \
		--with-gcc \
		--without-dbg \
		--with-prof \
		${myconf} || die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog NEWS README
}
