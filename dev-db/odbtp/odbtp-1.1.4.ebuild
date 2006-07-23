# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/odbtp/odbtp-1.1.4.ebuild,v 1.1 2006/07/23 19:49:53 chtekk Exp $

KEYWORDS="~x86"
DESCRIPTION="ODBTP is a fast, efficient TCP/IP protocol for connecting to Win32-based databases from any platform."
HOMEPAGE="http://odbtp.sourceforge.net/"
SRC_URI="mirror://sourceforge/odbtp/${P}.tar.gz"
LICENSE="GPL-2 LGPL-2"
SLOT="0"
IUSE="doc"

src_compile() {
	econf || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	# Install various documentation
	dodoc AUTHORS INSTALL NEWS README*
	if useq doc ; then
		dohtml -r docs/*
	fi
}
