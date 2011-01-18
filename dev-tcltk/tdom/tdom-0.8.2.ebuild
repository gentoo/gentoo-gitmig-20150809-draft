# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tdom/tdom-0.8.2.ebuild,v 1.6 2011/01/18 14:47:35 hwoarang Exp $

EAPI="3"

inherit autotools eutils

MY_P="tDOM-${PV}"

DESCRIPTION="A XML/DOM/XPath/XSLT Implementation for Tcl"
HOMEPAGE="http://www.tdom.org/"
SRC_URI="http://www.tdom.org/files/${MY_P}.tgz"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="threads"

DEPEND="
	dev-lang/tcl
	dev-libs/expat"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch \
		"${FILESDIR}/${P}.patch" \
		"${FILESDIR}/${P}-soname.patch" \
		"${FILESDIR}/${P}-expat.patch" \
		"${FILESDIR}/${P}-tnc.patch"
	eautoreconf
}

src_configure() {
	local myconf=""

	myconf="${myconf}
		$(use_enable threads)
		--enable-shared
		--disable-tdomalloc
		--with-expat"

	cd "${S}"/unix
	ECONF_SOURCE=".." econf ${myconf}

	# compile tdomhtml
	cd "${S}"/extensions/tdomhtml
	econf

	# compile tnc
	cd "${S}"/extensions/tnc
	econf ${myconf}
}

src_compile() {
	cd "${S}"/unix
	emake || die "failed to compile tdom"

	# compile tdomhtml
	cd "${S}"/extensions/tdomhtml
	emake || die "fail to compile tdomhtml"

	# compile tnc
	cd "${S}"/extensions/tnc
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
	dodoc CHANGES ChangeLog README* || die
}
