# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xqilla/xqilla-9999.ebuild,v 1.2 2008/10/15 10:27:42 dev-zero Exp $

ESVN_REPO_URI="http://xqilla.svn.sourceforge.net/svnroot/xqilla/trunk/xqilla"

inherit autotools subversion

DESCRIPTION="An XQuery and XPath 2 library and command line utility written in C++."
HOMEPAGE="http://xqilla.sourceforge.net/HomePage"
LICENSE="Sleepycat BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc faxpp htmltidy"

RDEPEND="faxpp? ( dev-libs/faxpp )
	>=dev-libs/xerces-c-3.0.0
	htmltidy? ( app-text/htmltidy )"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

S="${WORKDIR}/${PN}"

src_unpack() {
	subversion_src_unpack

	cd "${S}"
	eautoreconf
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
