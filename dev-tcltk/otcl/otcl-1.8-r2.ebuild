# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/otcl/otcl-1.8-r2.ebuild,v 1.2 2004/08/03 12:01:35 dholm Exp $

inherit eutils

DESCRIPTION="MIT Object extention to Tcl"
SF_PN="otcl-tclcl"
HOMEPAGE="http://sourceforge.net/projects/${SF_PN}/"
SRC_URI="mirror://sourceforge/${SF_PN}/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"
IUSE=""
DEPEND=">=dev-lang/tcl-8.3.2
		>=dev-lang/tk-8.3.2"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/otcl-1.8-badfreefix.patch
}

src_compile() {
	local tclv tkv myconf
	tclv=$(grep TCL_VER /usr/include/tcl.h | sed 's/^.*"\(.*\)".*/\1/')
	tkv=$(grep TK_VER /usr/include/tk.h | sed 's/^.*"\(.*\)".*/\1/')
	myconf="--with-tcl-ver=${tclv} --with-tk-ver=${tkv}"
	CFLAGS="${CFLAGS} -I/usr/lib/tcl${tkv}/include/generic"
	econf ${myconf} || die "econf failed"
	emake all || die "emake all failed"
	emake libotcl.so || die  "emake libotcl.so failed"
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
