# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gmorgan/gmorgan-0.22.ebuild,v 1.1 2004/02/27 23:40:07 torbenh Exp $

DESCRIPTION="gmorgan is an opensource software rhythm station."
HOMEPAGE="http://personal.telefonica.terra.es/web/soudfontcombi/"
SRC_URI="http://personal.telefonica.terra.es/web/soudfontcombi/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND=">=x11-libs/fltk-1.1.2
	>=media-libs/alsa-lib-0.9.0"

S="${WORKDIR}/${P}"

src_unpack() {
	unpack ${A}
	cd ${S}/po
	sed -i "/mkinstalldirs =/s%.*%mkinstalldirs = ../mkinstalldirs%" Makefile.in.in
}

src_compile() {
	./configure --prefix=/usr || die "./configure failed"
	emake || die "compile failed"
}

src_install() {
	make prefix=${D}/usr install || die
	dodoc AUTHORS COPYING INSTALL NEWS README
}


