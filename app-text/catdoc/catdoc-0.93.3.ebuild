# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/catdoc/catdoc-0.93.3.ebuild,v 1.4 2004/09/05 11:57:22 malc Exp $

DESCRIPTION="A convertor for Microsoft Word, Excel and RTF Files to text"
HOMEPAGE="http://www.45.free.net/~vitus/ice/catdoc/"
SRC_URI="ftp://ftp.45.free.net/pub/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

IUSE="tcltk"
SLOT="0"
KEYWORDS="x86 ~amd64"

DEPEND="tcltk? ( >=dev-lang/tk-8.1 )"

DOCS="CODING.STD COPYING CREDITS INSTALL NEWS README TODO"

src_compile() {

	local myconf="--with-install-root=${D}"

	use tcltk \
		&& myconf="${myconf} --with-wish=/usr/bin/wish" \
		|| myconf="${myconf} --disable-wordview"

	econf ${myconf} || die
	emake LIB_DIR=/usr/share/catdoc || die

}

src_install() {

	make mandir=/usr/share/man/man1 install || die
	dodoc ${DOCS}

}


