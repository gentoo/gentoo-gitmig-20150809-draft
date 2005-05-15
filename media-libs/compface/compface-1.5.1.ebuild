# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/compface/compface-1.5.1.ebuild,v 1.4 2005/05/15 02:57:08 weeve Exp $

IUSE=""

inherit eutils

DESCRIPTION="Utilities and library to convert to/from X-Face format"
HOMEPAGE="http://www.xemacs.org/Download/optLibs.html"
SRC_URI="http://ftp.xemacs.org/pub/xemacs/aux/${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~alpha ~amd64 ~hppa ia64 ~ppc ~ppc-macos ~ppc64 sparc x86"
SLOT="0"

DEPEND="virtual/libc"

src_unpack() {

	unpack ${A}
	cd ${S}

	sed -i -e "s:\r::" Makefile.in
	epatch ${FILESDIR}/${P}-destdir.diff
	WANT_AUTOCONF=2.5 autoconf

}

src_install() {

	dodir /usr/share/man/man{1,3} /usr/{bin,include,$(get_libdir)}
	make DESTDIR="${D}" install || die

	newbin xbm2xface{.pl,}
	dodoc README ChangeLog

}
