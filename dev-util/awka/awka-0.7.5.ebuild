# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/awka/awka-0.7.5.ebuild,v 1.2 2003/09/06 20:32:23 msterret Exp $

DESCRIPTION="An AWK-to-C tranlator."
SRC_URI="http://${PN}.sourceforge.net/${P}.tar.gz"
HOMEPAGE="http://awka.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~sparc ~alpha"

IUSE=""
DEPEND="virtual/glibc"

src_compile() {

	## TODO: add config-option for "NO_BIN_CHARS"!

	./configure \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--includedir=/usr/include \
		|| die "./configure failed"
	emake || die "make failed"
}

src_install() {
	make prefix=${D} \
		MANSRCDIR=${D}/usr/share/man \
		INCDIR=${D}/usr/include \
		install || die "install failed"

	dodoc ACKNOWLEDGEMENTS *.txt
	dohtml doc/*
}

