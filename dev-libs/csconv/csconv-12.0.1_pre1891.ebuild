# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/csconv/csconv-12.0.1_pre1891.ebuild,v 1.2 2004/10/14 20:10:53 dholm Exp $

inherit iiimf eutils

DESCRIPTION="A code conversion library for IIIMF"

LICENSE="IBM"
KEYWORDS="~x86 ~ppc"
IUSE="debug"

DEPEND="sys-devel/automake
	sys-devel/autoconf"
RDEPEND="virtual/libc"

S="${WORKDIR}/${IMSDK}/lib/CSConv"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P%_*}-gentoo.diff
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
