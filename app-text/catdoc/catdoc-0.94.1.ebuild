# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/catdoc/catdoc-0.94.1.ebuild,v 1.1 2006/02/09 21:51:43 nattfodd Exp $

DESCRIPTION="A convertor for Microsoft Word, Excel and RTF Files to text"
HOMEPAGE="http://www.45.free.net/~vitus/software/catdoc/"
SRC_URI="ftp://ftp.45.free.net/pub/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

IUSE="tcltk"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"

DEPEND="tcltk? ( >=dev-lang/tk-8.1 )"

DOCS="CODING.STD CREDITS NEWS README TODO"

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


