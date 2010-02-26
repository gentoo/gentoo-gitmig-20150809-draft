# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xqilla/xqilla-2.2.3.ebuild,v 1.1 2010/02/26 07:56:47 dev-zero Exp $

EAPI="2"
inherit eutils

MY_P="XQilla-${PV}"

DESCRIPTION="An XQuery and XPath 2 library and command line utility written in C++."
HOMEPAGE="http://xqilla.sourceforge.net/HomePage"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
LICENSE="Apache-2.0 BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc faxpp htmltidy"

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
	epatch "${FILESDIR}/${PV}-xerces-c-3.1.0.patch"
	sed -i -e 's|^LDFLAGS =|LDFLAGS +=|' Makefile.in || die "sed failed"
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
}
