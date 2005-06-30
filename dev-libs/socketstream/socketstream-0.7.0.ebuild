# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/socketstream/socketstream-0.7.0.ebuild,v 1.1 2005/06/30 05:11:37 ka0ttic Exp $

DESCRIPTION="C++ Streaming sockets library"
HOMEPAGE="http://socketstream.sourceforge.net/"
SRC_URI="mirror://sourceforge/socketstream/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ppc ~sparc ~hppa ~amd64"
IUSE="doc"

DEPEND="doc? ( app-doc/doxygen )"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"

	if use doc ; then
		emake doxygen || die "failed to build docs"
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
	use doc && dohtml -r docs/html/*
}
