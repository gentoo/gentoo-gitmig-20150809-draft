# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gradio/gradio-1.0.1.ebuild,v 1.12 2004/11/12 08:33:30 eradicator Exp $

IUSE=""

DESCRIPTION="GTK based app for radio tuner cards"
SRC_URI="ftp://ftp.foobazco.org/pub/gradio/${P}.tar.gz"
HOMEPAGE="http://foobazco.org/projects/gradio/"

SLOT="0"
LICENSE="GPL-2"

KEYWORDS="amd64 sparc x86"

DEPEND="=x11-libs/gtk+-1.2*"

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
