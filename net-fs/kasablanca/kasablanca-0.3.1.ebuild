# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/kasablanca/kasablanca-0.3.1.ebuild,v 1.3 2004/04/26 07:30:49 dholm Exp $

inherit kde
need-kde 3.1

DESCRIPTION="a graphical ftp client for kde. among its features are support for ssl/tls encryption (both commands and data using auth tls, not sftp), fxp (direct ftp to ftp transfer) bookmarks, and queues."
HOMEPAGE="http://kasablanca.berlios.de/"
SRC_URI="http://download.berlios.de/kasablanca/kasablanca-${PV}.tar.gz"
LICENSE="GPL-2"
RESTRICT="nomirror"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

# commondpends based on (ldd /usr/bin/kasablanca ; ldd /usr/bin/kbftp ) |\
# cut -f3 -d ' ' | xargs -n1 qpkg -f -v  | sort | uniq
COMMONDEPENDS="dev-libs/expat
	dev-libs/openssl
	kde-base/kdelibs
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
	x11-base/xfree
	x11-libs/qt"

DEPEND="${DEPEND}
	sys-apps/gawk
	sys-apps/sed
	sys-devel/libtool
	>=sys-devel/automake-1.6
	sys-devel/autoconf
	sys-devel/gettext
	${COMMONDEPENDS}"


RDEPEND="${RDEPEND}
	${COMMONDEPENDS}"




src_install() {
	kde_src_install all
	mv ${D}/usr/share/doc/HTML ${D}/usr/share/doc/${PF}
}
