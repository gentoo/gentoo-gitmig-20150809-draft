# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclcl/tclcl-1.16.ebuild,v 1.1 2005/04/03 13:56:05 matsuu Exp $

inherit eutils

MY_P="${PN}-src-${PV}"
DESCRIPTION="Tcl/C++ interface library"
HOMEPAGE="http://otcl-tclcl.sourceforge.net/tclcl/"
SRC_URI="mirror://sourceforge/otcl-tclcl/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64"
IUSE=""

DEPEND=">=dev-lang/tcl-8.3.2
	>=dev-lang/tk-8.3.2
	>=dev-tcltk/otcl-1.0.8"

src_compile() {
	local tclv tkv myconf

	tclv=$(grep TCL_VER /usr/include/tcl.h | sed 's/^.*"\(.*\)".*/\1/')
	tkv=$(grep TK_VER /usr/include/tk.h | sed 's/^.*"\(.*\)".*/\1/')
	myconf="--with-tcl-ver=${tclv} --with-tk-ver=${tkv}"

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dolib.a libtclcl.a
	dobin tcl2c++
	insinto /usr/include
	doins *.h

	dodoc FILES README VERSION
	dohtml CHANGES.html
}
