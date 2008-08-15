# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xqilla/xqilla-2.1.3.ebuild,v 1.1 2008/08/15 08:59:50 dev-zero Exp $

inherit eutils

MY_P="XQilla-${PV}"

DESCRIPTION="An XQuery and XPath 2 library and command line utility written in C++."
HOMEPAGE="http://xqilla.sourceforge.net/HomePage"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
LICENSE="Sleepycat BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc faxpp htmltidy"

RDEPEND="faxpp? ( dev-libs/faxpp )
	~dev-libs/xerces-c-2.8.0
	htmltidy? ( app-text/htmltidy )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if ! built_with_use dev-libs/xerces-c xqilla ; then
		eerror "dev-libs/xerces-c has to be built with the xqilla USE-flag"
		die "missing xqilla USE-flag for dev-libs/xerces-c"
	fi
}

src_compile() {
	econf \
		--with-xerces=/usr \
		$(use_enable debug) \
		$(use_with htmltidy tidy) \
		$(use_with faxpp faxpp /usr)

	emake || die "emake failed"

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
