# Copyright 2002 Gentoo 
# $Header: /var/cvsroot/gentoo-x86/media-sound/gradio/gradio-1.0.1.ebuild,v 1.1 2002/07/17 22:47:13 bass Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GTK based app for radio tuner cards"
SRC_URI="ftp://ftp.foobazco.org/pub/gradio/${P}.tar.gz"

HOMEPAGE="http://foobazco.org/projects/gradio/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="=x11-libs/gtk+-1.2*"
RDEPEND="${DEPEND}"
 

src_compile() {
	
	emake || die
}

src_install () {
	
	dodir /usr/bin
	dodir /usr/share/man/man1
	einstall \
	BINDIR=${D}/usr/bin \
	MANDIR=${D}/usr/share/man/man1 || die
	
	dodoc Changes COPYING README
}
