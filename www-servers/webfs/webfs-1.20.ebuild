# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/webfs/webfs-1.20.ebuild,v 1.2 2004/08/30 23:44:03 dholm Exp $

IUSE="ssl"

S=${WORKDIR}/${P}
DESCRIPTION="Lightweight HTTP server for static content"
SRC_URI="http://bytesex.org/misc/webfs_${PV}.tar.gz"
HOMEPAGE="http://bytesex.org/webfs.html"

KEYWORDS="x86 sparc alpha ~ppc"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/libc
	ssl? ( dev-libs/openssl )"

RDEPEND="${DEPEND}
	app-misc/mime-types"

src_compile() {

	local myconf=""

	use ssl \
		|| myconf="${myconf} USE_SSL=no"

	emake prefix=/usr ${myconf}
}

src_install() {
	einstall mandir=${D}/usr/share/man
	dodoc README COPYING
}
