# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclcl/tclcl-1.15.ebuild,v 1.8 2004/10/26 22:05:33 sekretarz Exp $

inherit eutils

DESCRIPTION="Tcl/C++ interface library"
SF_PN="otcl-tclcl"
HOMEPAGE="http://sourceforge.net/projects/${SF_PN}/"
MY_P="${PN}-src-${PV}"
SRC_URI="mirror://sourceforge/${SF_PN}/${MY_P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 sparc ~amd64"
IUSE=""
DEPEND=">=dev-lang/tcl-8.3.2
		>=dev-lang/tk-8.3.2
		>=dev-tcltk/otcl-1.0.8"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-gcc34.patch

	libtoolize -f
}

src_compile() {
	local tclv tkv
	tclv=$(grep TCL_VER /usr/include/tcl.h | sed 's/^.*"\(.*\)".*/\1/')
	tkv=$(grep TK_VER /usr/include/tk.h | sed 's/^.*"\(.*\)".*/\1/')
	local myconf="--with-tcl-ver=${tclv} --with-tk-ver=${tkv}"
	econf ${myconf} || die "econf failed"
	sed 's|$(LIBRARY_TCL)/http.*/http.tcl|$(LIBRARY_TCL)/http2.4/http.tcl|g' \
		-i Makefile || die "sed failed"
	emake || die "emake failed"
}

src_install() {
	dolib.a libtclcl.a
	dobin tcl2c++
	dodir /usr/include
	insinto /usr/include
	doins *.h
	dohtml CHANGES.html
	dodoc FILES README VERSION
}
