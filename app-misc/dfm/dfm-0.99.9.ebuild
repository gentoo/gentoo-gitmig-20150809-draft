# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/dfm/dfm-0.99.9.ebuild,v 1.1 2002/07/12 01:29:16 stroke Exp $

S=${WORKDIR}/dfm
DESCRIPTION="Desktop Manager. Good replacement for gmc or nautilus"
SRC_URI="http://www.kaisersite.de/dfm/${P}.tar.gz"
HOMEPAGE="http://www.kaisersite.de/dfm/"

LICENSE="GPL-2"
KEYWORDS="*"
SLOT="0"


DEPEND="=x11-libs/gtk+-1.2*
	=media-libs/imlib-1.9*"
RDEPEND="${DEPEND}"

src_compile() {

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc/ \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die
	
	emake || die
}

src_install () {

	make prefix=${D}/usr \
		sysconfdir=${D}/etc/ \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		install || die

	dodoc README INSTALL ChangeLog TODO NEWS AUTHORS
}

