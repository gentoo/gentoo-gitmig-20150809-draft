# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/csconv/csconv-11.4.1467.ebuild,v 1.6 2004/07/14 14:11:13 agriffis Exp $

inherit iiimf eutils

DESCRIPTION="A code conversion library for IIIMF"

LICENSE="IBM"
KEYWORDS="~x86"
IUSE="debug"

S="${WORKDIR}/${IMSDK}/lib/CSConv"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
	econf --prefix=/usr/lib/im \
		--enable-optimize \
		`use_enable debug` || die
	# emake doesn't work
	make || die
}

src_install() {
	einstall prefix=${D}/usr/lib/im || die

	cd ${WORKDIR}/${IMSDK}/doc/conv
	doman *.[1-9]
	dodoc ChangeLog INSTALL README*
}
