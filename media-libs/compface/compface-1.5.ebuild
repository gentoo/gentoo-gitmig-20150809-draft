# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/compface/compface-1.5.ebuild,v 1.2 2005/01/06 16:18:24 hattya Exp $

IUSE=""

inherit eutils

DESCRIPTION="Utilities and library to convert to/from X-Face format"
HOMEPAGE="http://www.xemacs.org/Download/optLibs.html"
SRC_URI="http://ftp.xemacs.org/pub/xemacs/aux/${P}.tar.gz"

RESTRICT="nomirror"
LICENSE="MIT"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64 ~ppc64 ~ppc-macos"
SLOT="0"

DEPEND="virtual/libc"

src_unpack() {

	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-destdir.diff
	WANT_AUTOCONF=2.5 autoconf

}

src_install() {

	dodir /usr/share/man/man{1,3} /usr/{bin,include,$(get_libdir)}
	make DESTDIR="${D}" install || die

	newbin xbm2xface{.pl,}
	dodoc README ChangeLog

}
