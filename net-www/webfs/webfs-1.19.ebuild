# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/webfs/webfs-1.19.ebuild,v 1.2 2003/06/20 16:06:02 joker Exp $

IUSE="ssl"

S=${WORKDIR}/${P}
DESCRIPTION="Lightweight HTTP server for static content"
SRC_URI="http://bytesex.org/misc/webfs_${PV}.tar.gz"
HOMEPAGE="http://bytesex.org/webfs.html"

KEYWORDS="x86 sparc"
LICENSE="GPL-2"
SLOT="0"

RDEPEND="virtual/glibc
	app-misc/mime-types
	ssl? ( dev-libs/openssl )"

DEPEND="${RDEPEND}"

src_compile() {

	local myconf=""

	use ssl \
		|| myconf="${myconf} USE_SSL=no"

	emake prefix=/usr ${myconf}
}

src_install() {
	einstall mandir=${D}/usr/share/man/man1
	dodoc README COPYING
}
