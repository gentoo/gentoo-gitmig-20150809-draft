# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/tdom/tdom-0.8.3.ebuild,v 1.1 2011/01/21 08:00:52 jlec Exp $

EAPI="3"

inherit autotools eutils

MY_P="tDOM-${PV}"

DESCRIPTION="A XML/DOM/XPath/XSLT Implementation for Tcl"
HOMEPAGE="http://tdom.github.com"
SRC_URI="http://cloud.github.com/downloads/tDOM/${PN}/${MY_P}.tgz"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="threads"

DEPEND="
	dev-lang/tcl
	dev-libs/expat"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch \
		"${FILESDIR}/"${PN}-0.8.2.patch \
		"${FILESDIR}/"${PN}-0.8.2-soname.patch \
		"${FILESDIR}/"${P}-expat.patch \
		"${FILESDIR}/"${PN}-0.8.2-tnc.patch
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
	local dir

	for dir in "${S}"/unix "${S}"/extensions/tdomhtml "${S}"/extensions/tnc; do
		pushd ${dir} > /dev/null
			emake || die
		popd > /dev/null
	done
}

src_install() {
	local dir

	dodoc CHANGES ChangeLog README* || die

	for dir in "${S}"/unix "${S}"/extensions/tdomhtml "${S}"/extensions/tnc; do
		pushd ${dir} > /dev/null
			emake DESTDIR="${D}" install || die
		popd > /dev/null
	done
}
