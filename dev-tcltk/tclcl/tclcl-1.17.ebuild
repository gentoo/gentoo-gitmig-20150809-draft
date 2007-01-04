# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclcl/tclcl-1.17.ebuild,v 1.2 2007/01/04 14:49:02 flameeyes Exp $

WANT_AUTOMAKE="latest"
WANT_AUTOCONF="latest"

inherit eutils autotools

#MY_P="${PN}-src-${PV}"
DESCRIPTION="Tcl/C++ interface library"
HOMEPAGE="http://otcl-tclcl.sourceforge.net/tclcl/"
SRC_URI="mirror://sourceforge/otcl-tclcl/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/tcl-8.4.5
		>=dev-lang/tk-8.4.5
		>=dev-tcltk/otcl-1.11"

src_unpack() {
	unpack ${A}
	EPATCH_OPTS="-p1 -d ${S}" epatch ${FILESDIR}/${PN}-1.16-http.patch
	EPATCH_OPTS="-p1 -d ${S}" epatch ${FILESDIR}/${PN}-1.17-configure-cleanup.patch
	cd "${S}"
	eautoreconf
}

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
