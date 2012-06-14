# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libproplist/libproplist-0.10.1-r3.ebuild,v 1.1 2012/06/14 15:43:21 ssuominen Exp $

EAPI=4

MY_P=libPropList-${PV}

DESCRIPTION="libPropList"
SRC_URI="ftp://ftp.windowmaker.org/pub/libs/${MY_P}.tar.gz"
HOMEPAGE="http://www.windowmaker.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64 alpha ia64"
IUSE=""

S=${WORKDIR}/${MY_P}

src_configure() {
	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var/state/libPropList \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--build=${CHOST} \
		--host=${CHOST} \
		--target=${CHOST} || die
}

src_compile() {
	make || die
}

src_install() {
	make prefix="${D}/usr" install || die
	dodoc AUTHORS ChangeLog README TODO
}
