# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tdom/tdom-0.8.2.ebuild,v 1.2 2010/03/29 20:09:59 jlec Exp $

inherit autotools eutils

MY_P="tDOM-${PV}"
DESCRIPTION="A XML/DOM/XPath/XSLT Implementation for Tcl"
HOMEPAGE="http://www.tdom.org/"
SRC_URI="http://www.tdom.org/files/${MY_P}.tgz"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="threads"

DEPEND=">=dev-lang/tcl-8.4.3
	>=dev-libs/expat-2.0.1"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}

	cd "${S}"
	#sed -i -e "s/relid'/relid/" configure* tclconfig/tcl.m4 \
	#	extensions/tnc/configure extensions/example/{configure,tcl.m4} || die
	epatch "${FILESDIR}/${P}.patch"
	epatch "${FILESDIR}/${P}-expat.patch"
	epatch "${FILESDIR}/${P}-tnc.patch"
	eautoreconf
}

src_compile() {
	local myconf=""

	myconf="${myconf} $(use_enable threads)
		--enable-shared
		--disable-tdomalloc
		--with-expat"

	cd "${S}"/unix
	ECONF_SOURCE=".." econf ${myconf} || die "failed to configure"
	emake || die "failed to compile tdom"

	# compile tdomhtml
	cd "${S}"/extensions/tdomhtml
	econf || die "fail to configure tdomhtml"
	emake || die "fail to compile tdomhtml"

	# compile tnc
	cd "${S}"/extensions/tnc
	econf ${myconf} || die "failed to configure tnc"
	emake || die "failed to compile tnc"
}

src_install() {
	cd "${S}"/unix
	emake DESTDIR="${D}" install || die

	cd "${S}"/extensions/tdomhtml
	emake DESTDIR="${D}" install || die

	cd "${S}"/extensions/tnc
	emake DESTDIR="${D}" install || die

	cd "${S}"
	dodoc CHANGES ChangeLog README*
}
