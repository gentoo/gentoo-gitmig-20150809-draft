# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gozer/gozer-0.7.ebuild,v 1.1 2002/06/03 22:28:32 stroke Exp $

S=${WORKDIR}/${P}
DESCRIPTION="tool for rendering arbitary text as graphics, using ttfs and styles"
SRC_URI="http://www.linuxbrit.co.uk/downloads/${P}.tar.gz"
HOMEPAGE="http://www.linuxbrit.co.uk/"
LICENSE="GPL-2"
SLOT="0"

DEPEND=">=x11-base/xfree-4.0.0
	>=media-libs/giblib-1.2.1"



src_compile() {

	./configure --infodir=/usr/share/info \
		    --mandir=/usr/share/man \
		    --prefix=/usr --host=${CHOST} || die

	emake || die
}

src_install() {

	make prefix=${D}/usr \
		mandir=${D}/usr/share/man install || die

	dodoc TODO README AUTHORS ChangeLog
}

