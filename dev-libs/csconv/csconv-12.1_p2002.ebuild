# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/csconv/csconv-12.1_p2002.ebuild,v 1.3 2005/04/24 12:37:36 hansmi Exp $

inherit iiimf eutils toolchain-funcs

DESCRIPTION="A code conversion library for IIIMF"
SRC_URI="http://www.openi18n.org/download/im-sdk/src/${IMSDK_P}.tar.bz2"

LICENSE="IBM"
KEYWORDS="x86 ppc"
IUSE="debug"

DEPEND="virtual/libc"

S="${WORKDIR}/${IMSDK}/lib/CSConv"

src_compile() {
	sed -i -e "s/\"gcc\"/\"$(tc-getCC)\"/g" configure || die
	econf --prefix=/usr/lib/im \
		--enable-optimize \
		$(use_enable debug) || die
	emake -j1 || die
}

src_install() {
	einstall prefix=${D}/usr/lib/im || die

	cd ${WORKDIR}/${IMSDK}/doc/conv
	doman *.[1-9]
	dodoc ChangeLog INSTALL README*
}
