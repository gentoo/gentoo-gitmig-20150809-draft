# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ogdi/ogdi-3.1.1.ebuild,v 1.2 2003/02/13 10:48:37 vapier Exp $

IUSE=""

S="${WORKDIR}/${P}"
DESCRIPTION="open geographical datastore interface"
SRC_URI="http://umn.dl.sourceforge.net/sourceforge/ogdi/${P}.tar.gz"
HOMEPAGE="http://ogdi.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="dev-libs/proj
	sys-libs/zlib
	dev-libs/expat"

src_compile() {

	export TOPDIR="${S}"
	export TARGET="linux"
	export CFG="release"
	export LD_LIBRARY_PATH="${TOPDIR}/bin/${TARGET}"

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--with-proj \
		--with-projlib=/usr/lib \
		--with-projinc=/usr/include \
		--with-zlib \
		--with-zliblib=/usr/lib \
		--with-zlibinc=/usr/include \
		--with-expat \
		--with-expatlib=/usr/lib \
		--with-expatinc=/usr/include || die "./configure failed"
	make || die
}

src_install () {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		TOPDIR="${S}" TARGET="linux" LD_LIBRARY_PATH="${TOPDIR}/bin/${TARGET}" \
		install || die

	dodoc ChangeLog LICENSE NEWS README VERSION
}

