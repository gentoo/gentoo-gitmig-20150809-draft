# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/otcl/otcl-1.8-r1.ebuild,v 1.2 2004/04/04 22:25:25 zx Exp $

DESCRIPTION="MIT Object extention to Tcl"
SF_PN="otcl-tclcl"
HOMEPAGE="http://sourceforge.net/projects/${SF_PN}/"
SRC_URI="mirror://sourceforge/${SF_PN}/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 ~sparc"
IUSE=""
DEPEND=">=dev-lang/tcl-8.3.2
		>=dev-lang/tk-8.3.2"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/otcl-1.8-badfreefix.patch
}

src_compile() {
	#local myconf="--with-tcl=/usr/lib --enable-shared"
	local myconf="--enable-shared"
	CFLAGS="${CFLAGS} -I`ls /usr/lib/tcl8.*/include/generic/tclInt.h | tail -n1 | xargs dirname`"
	econf ${myconf}
	emake all || die
	emake libotcl.so || die
}

src_install() {
	into /usr
	dobin otclsh owish
	dolib libotcl.so
	dolib.a libotcl.a
	insinto /usr/include
	doins otcl.h

	# docs
	dodoc VERSION
	dohtml README.html CHANGES.html
	docinto doc
	dodoc doc/*
}
