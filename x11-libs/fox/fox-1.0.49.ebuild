# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/fox/fox-1.0.49.ebuild,v 1.2 2004/02/17 20:08:52 agriffis Exp $

IUSE="cups opengl"
S=${WORKDIR}/${P}
DESCRIPTION="C++ based Toolkit for developing Graphical User Interfaces easily and effectively"
SRC_URI="http://www.fox-toolkit.org/ftp/${P}.tar.gz"
HOMEPAGE="http://www.fox-toolkit.org"

SLOT="0"
KEYWORDS="~x86 ~sparc alpha ia64"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	virtual/x11
	opengl? ( virtual/opengl )"


src_compile() {

	local myconf

	use opengl || myconf="$myconf --with-opengl=no" #default enabled
	use cups && myconf="$myconf --enable-cups"      #default disabled

	./configure \
		--prefix=/usr \
		--mandir='${prefix}'/share/man \
		--host=${CHOST} \
		${myconf} || die "Configuration Failed"

	emake || die "Parallel Make Failed"
}

src_install () {

	make prefix=${D}/usr/ \
		install || die "Installation Failed"

	dodoc README INSTALL LICENSE ADDITIONS AUTHORS TRACING

	dodir /usr/share/doc/${PF}/html
	mv ${D}/usr/fox/html/* ${D}/usr/share/doc/${PF}/html/
	rmdir ${D}/usr/fox/html
	rmdir ${D}/usr/fox
}
