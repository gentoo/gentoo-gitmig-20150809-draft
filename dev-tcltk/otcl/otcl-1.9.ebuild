# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/otcl/otcl-1.9.ebuild,v 1.1 2005/04/03 13:47:58 matsuu Exp $

inherit eutils

DESCRIPTION="MIT Object extension to Tcl"
HOMEPAGE="http://otcl-tclcl.sourceforge.net/otcl/"
SRC_URI="mirror://sourceforge/otcl-tclcl/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE=""

DEPEND=">=dev-lang/tcl-8.3.2
	>=dev-lang/tk-8.3.2"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/otcl-1.8-badfreefix.patch
	sed -i \
		-e "s/) otkAppInit.c/) otkAppInit.c otcl.c/" \
		-e "s/) otclAppInit.c/) otclAppInit.c otcl.c/" \
		${S}/Makefile.in || die "sed Makefile failed"

	libtoolize -f
}

src_compile() {
	local tclv tkv myconf
	tclv=$(grep TCL_VER /usr/include/tcl.h | sed 's/^.*"\(.*\)".*/\1/')
	tkv=$(grep TK_VER /usr/include/tk.h | sed 's/^.*"\(.*\)".*/\1/')
	myconf="--with-tcl-ver=${tclv} --with-tk-ver=${tkv}"
	CFLAGS="${CFLAGS} -I/usr/$(get_libdir)/tcl${tkv}/include/generic"

	econf ${myconf} || die "econf failed"
	emake all || die "emake all failed"
	emake libotcl.so || die  "emake libotcl.so failed"
}

src_install() {
	dobin otclsh owish
	dolib libotcl.so
	dolib.a libotcl.a
	insinto /usr/include
	doins otcl.h

	# docs
	dodoc VERSION
	dohtml README.html CHANGES.html
	docinto doc
	dohtml doc/*.html
}
