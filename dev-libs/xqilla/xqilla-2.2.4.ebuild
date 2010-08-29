# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xqilla/xqilla-2.2.4.ebuild,v 1.1 2010/08/29 11:47:00 dev-zero Exp $

EAPI="2"
inherit autotools eutils

MY_P="XQilla-${PV}"

DESCRIPTION="An XQuery and XPath 2 library and command line utility written in C++."
HOMEPAGE="http://xqilla.sourceforge.net/HomePage"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
LICENSE="Apache-2.0 BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc examples faxpp htmltidy"

# XQilla bundles two libraries:
# - mapm, heavily patched
# - yajl, moderately patched
# There's currently no way to unbundle those

RDEPEND=">=dev-libs/xerces-c-3.1.0
	faxpp? ( dev-libs/faxpp )
	htmltidy? ( app-text/htmltidy )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	# respect our LDFLAGS and don't add an rpath for the xerces-c lib
	# since that is in the default LDPATH anyway and the binaries
	# may need relinking at install-time because they temporary use
	# already installed libraries
	epatch "${FILESDIR}/${PV}-respect-ldflags-no-rpath.patch"
	eautoreconf
}

src_configure() {
	econf \
		--with-xerces=/usr \
		$(use_enable debug) \
		$(use_with htmltidy tidy) \
		$(use_with faxpp faxpp /usr)
}

src_compile() {
	default

	if use doc; then
		emake docs || die "emake docs failed"
		emake devdocs || die "emake devdocs failed"
	fi
}

src_install () {
	emake DESTDIR="${D}" install || die "emake docs failed"

	dodoc ChangeLog TODO

	if use doc; then
		cd docs
		dohtml -r dev-api dom3-api simple-api
	fi
	if use examples ; then
		insinto /usr/share/doc/${PF}/examples
		doins -r "${S}"/src/samples/*
	fi
}
