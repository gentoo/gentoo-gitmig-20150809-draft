# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/kasablanca/kasablanca-0.4.0.1.ebuild,v 1.5 2005/03/24 02:10:10 luckyduck Exp $

inherit kde 64-bit eutils

DESCRIPTION="a graphical ftp client for kde. among its features are support for ssl/tls encryption (both commands and data using auth tls, not sftp), fxp (direct ftp to ftp transfer) bookmarks, and queues."
HOMEPAGE="http://kasablanca.berlios.de/"
SRC_URI="http://download.berlios.de/kasablanca/kasablanca-${PV}.tar.gz"
LICENSE="GPL-2"
RESTRICT="nomirror"
SLOT="0"
KEYWORDS="x86 ~ppc amd64"
IUSE=""

# commondpends based on (ldd /usr/bin/kasablanca ; ldd /usr/bin/kbftp ) |\
# cut -f3 -d ' ' | xargs -n1 qpkg -f -v  | sort | uniq
COMMONDEPENDS="dev-libs/expat
	dev-libs/openssl
	media-libs/fontconfig
	media-libs/freetype
	media-libs/jpeg
	media-libs/libart_lgpl
	media-libs/libmng
	media-libs/libpng
	media-libs/nas
	sys-devel/gcc
	sys-libs/glibc
	sys-libs/zlib
	virtual/x11
	x11-libs/qt"

DEPEND="${DEPEND}
	sys-apps/gawk
	sys-apps/sed
	sys-devel/libtool
	>=sys-devel/automake-1.6
	sys-devel/autoconf
	sys-devel/gettext
	dev-lang/perl
	${COMMONDEPENDS}"


RDEPEND="${RDEPEND}
	${COMMONDEPENDS}"


need-kde 3.1

src_unpack() {
	unpack ${A}
	if 64-bit ; then
		epatch ${FILESDIR}/${P}-64bit.patch
	fi
}

src_install() {
	kde_src_install all
	mv ${D}/usr/share/doc/HTML ${D}/usr/share/doc/${PF}
}
