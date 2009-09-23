# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/awka/awka-0.7.5.ebuild,v 1.13 2009/09/23 17:40:29 patrick Exp $

inherit eutils toolchain-funcs

DESCRIPTION="An AWK-to-C translator."
SRC_URI="http://${PN}.sourceforge.net/${P}.tar.gz"
HOMEPAGE="http://awka.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

IUSE=""
DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {

	## TODO: add config-option for "NO_BIN_CHARS"!

	./configure \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--includedir=/usr/include \
		|| die "./configure failed"
	emake CC="$(tc-getCC)" || die "make failed"
}

src_install() {
	make prefix="${D}" \
		MANSRCDIR="${D}"/usr/share/man \
		INCDIR="${D}"/usr/include \
		LIBDIR="${D}"/usr/$(get_libdir) \
		install || die "install failed"

	dodoc ACKNOWLEDGEMENTS *.txt
	dohtml doc/*
}
