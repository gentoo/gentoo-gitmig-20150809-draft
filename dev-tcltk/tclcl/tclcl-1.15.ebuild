# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclcl/tclcl-1.15.ebuild,v 1.1 2004/01/11 04:08:22 robbat2 Exp $

DESCRIPTION="tcl librairy"
SF_PN="otcl-tclcl"
HOMEPAGE="http://sourceforge.net/projects/${SF_PN}/"
MY_P="${PN}-src-${PV}"
SRC_URI="mirror://sourceforge/${SF_PN}/${MY_P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""
DEPEND=">=dev-lang/tcl-8.3.2
		>=dev-lang/tk-8.3.2
		>=dev-tcltk/otcl-1.0.8"
S=${WORKDIR}/${P}

src_compile() {
	econf || die
	sed 's|$(LIBRARY_TCL)/http/http.tcl|$(LIBRARY_TCL)/http2.4/http.tcl|g' -i Makefile
	#sed s/http2.3/http2.4/ -i Makefile
	emake || die 
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
