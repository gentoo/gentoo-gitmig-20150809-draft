# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/webfs/webfs-1.19.ebuild,v 1.1 2003/06/20 15:56:25 joker Exp $

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

	if [ -z "`use ssl`" ]
	then
		cp Make.config Make.config.orig
		sed 's/^\(USE_SSL.*:= \)yes/\1no/' Make.config.orig >Make.config
	fi

	emake prefix=/usr
}

src_install() {
	einstall mandir=${D}/usr/share/man/man1
	dodoc README COPYING
}
