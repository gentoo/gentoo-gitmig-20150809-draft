# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/awka/awka-0.7.5.ebuild,v 1.10 2007/07/12 01:05:42 mr_bones_ Exp $

inherit eutils

DESCRIPTION="An AWK-to-C translator."
SRC_URI="http://${PN}.sourceforge.net/${P}.tar.gz"
HOMEPAGE="http://awka.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

IUSE=""
DEPEND="virtual/libc"

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
		LIBDIR=${D}/usr/$(get_libdir) \
		install || die "install failed"

	dodoc ACKNOWLEDGEMENTS *.txt
	dohtml doc/*
}
