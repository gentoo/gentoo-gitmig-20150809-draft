# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclxml-expat/tclxml-expat-2.4-r1.ebuild,v 1.1 2009/08/08 02:25:55 mescalinum Exp $

inherit eutils

DESCRIPTION="Tcl wrapper libraries for expat XML parser."
HOMEPAGE="http://tclxml.sourceforge.net/"
SRC_URI="mirror://sourceforge/tclxml/tclxml-${PV}.tar.gz"
IUSE=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~sparc ~x86"

DEPEND=">=dev-lang/tcl-8.3.3
	>=dev-libs/expat-1.95.4
	=dev-tcltk/tclxml-${PV}*"
RDEPEND="${DEPEND}"

S=${WORKDIR}/tclxml-${PV}/expat

src_unpack() {
	unpack ${A}
	cd "${S}"

	# bug 253515 - bundles an internal copy of expat
	pushd ..
	epatch "${FILESDIR}"/${PN}-no-bundle.patch
	rm -f "${S}"/xmlparse/xmlparse.[ch] "${S}"/xmltok/xmltok_ns.c \
		"${S}"/xmltok/xmltok.[ch] "${S}"/xmltok/xmlrole.[ch]
	popd
}
src_compile() {
	econf --with-tcl=/usr/lib --with-Tclxml=/usr/lib || die
	make || die
}

src_install() {
	einstall || die
	dohtml expat.html
}
