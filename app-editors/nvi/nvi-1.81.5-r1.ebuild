# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/nvi/nvi-1.81.5-r1.ebuild,v 1.1 2003/08/18 07:38:07 robbat2 Exp $

DESCRIPTION="Vi clone"
SRC_URI="http://www.kotnet.org/~skimo/nvi/devel/${P}.tar.gz"
HOMEPAGE="http://www.bostic.com/vi/"
SLOT="0"
LICENSE="Sleepycat"
KEYWORDS="-*"
DEPEND="virtual/glibc
		=sys-libs/db-3*"
PROVIDE="virtual/editor"
IUSE=""

src_unpack() {
	unpack ${P}.tar.gz
	sed 's|-ldb|-ldb-3|g' -i ${S}/dist/configure
}

src_compile() {
	local myconf=""
	myconf="${myconf} --enable-dynamic-loading"
	export LIBS="-lpthread"
	cd build.unix
	../dist/configure \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--prefix=/usr \
		--host=${CHOST} \
		${myconf} || die "configure failed"
	einfo "Doing make now"
	emake || die "emake failed"
}

src_install() {
	cd ${S}/build.unix
	einstall
}
