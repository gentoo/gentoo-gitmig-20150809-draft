# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tclxml/tclxml-3.2.ebuild,v 1.3 2010/06/24 09:08:48 jlec Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Pure Tcl implementation of an XML parser."
HOMEPAGE="http://tclxml.sourceforge.net/"
SRC_URI="mirror://sourceforge/tclxml/${P}.tar.gz"

IUSE="expat threads xml"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

DEPEND="
	>=dev-lang/tcl-8.2
	dev-libs/libxslt
	>=dev-tcltk/tcllib-1.2
	xml? ( >=dev-libs/libxml2-2.6.9 )
	expat? ( dev-libs/expat )
	!dev-tcltk/tclxml-expat"
#	test? ( dev-tcltk/tclparser )
RDEPEND="${DEPEND}"

RESTRICT="test"

src_prepare() {
	epatch "${FILESDIR}"/"${P}"-fix-implicit-declarations.patch
}

src_compile() {
	local myconf=""

	use threads && myconf="${myconf} --enable-threads"

	econf ${myconf} || die
	emake || die

	if use xml ; then
		cd "${S}"/libxml2
		econf ${myconf} --with-Tclxml=.. || die
		emake || die
	fi
	if use expat ; then
		cd "${S}"/expat
		econf ${myconf} --with-Tclxml=.. || die
		emake || die
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die

	if use xml ; then
		cd "${S}"/libxml2
		emake DESTDIR="${D}" install || die
	fi
	if use expat ; then
		cd "${S}"/expat
		emake DESTDIR="${D}" install || die
	fi

	cd "${S}"
	dodoc ANNOUNCE ChangeLog
	dohtml doc/*.html
}
