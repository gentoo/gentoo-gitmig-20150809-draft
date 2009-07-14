# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/qoauth/qoauth-0.1.0.ebuild,v 1.1 2009/07/14 18:51:26 hwoarang Exp $

EAPI="2"

inherit qt4

DESCRIPTION="A Qt-based library for OAuth support"
HOMEPAGE="http://wiki.github.com/ayoy/qoauth"
SRC_URI="http://files.ayoy.net/qoauth/release/${PV}/src/${P}-src.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc"

DEPEND="app-crypt/qca:2[debug?]"
RDEPEND="${DEPEND}
	app-crypt/qca-ossl:2[debug?]"

src_prepare() {
	qt4_src_prepare
	sed -i -e '/^ *docs \\$/d' \
		   -e "s!\(\$\${INSTALL_PREFIX}\)/lib!\1/$(get_libdir)!" ${PN}.pro
	sed -i -e "s/\(.*\)lib$/\1$(get_libdir)/" pcfile.sh
}

src_configure() {
	eqmake4
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
	dodoc README CHANGELOG || die "dodoc failed"

	if use doc; then
		dohtml -r "${S}"/doc/html/* || die "Failed to install documentation"
	fi
}
