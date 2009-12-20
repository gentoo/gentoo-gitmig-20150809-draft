# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/qoauth/qoauth-1.0-r1.ebuild,v 1.2 2009/12/20 19:34:06 ayoy Exp $

EAPI="2"

inherit qt4-r2

DESCRIPTION="A Qt-based library for OAuth support"
HOMEPAGE="http://wiki.github.com/ayoy/qoauth"
SRC_URI="http://files.ayoy.net/qoauth/release/${PV}/src/${P}-src.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc static-libs test"

COMMON_DEPEND="app-crypt/qca:2[debug?]"
DEPEND="${COMMON_DEPEND}
	doc? ( app-doc/doxygen )"
RDEPEND="${COMMON_DEPEND}
	app-crypt/qca-ossl:2[debug?]"

src_prepare() {
	sed -i -e '/^ *docs \\$/d' \
		   -e '/^ *build_all \\$/d' \
		   -e 's/^\#\(!macx\)/\1/' \
		   -e "s!\(\$\${INSTALL_PREFIX}\)/lib!\1/$(get_libdir)!" \
		src/src.pro || die "sed failed"

	# remove _debug suffix - bug 287489
	sed -i -e '/build_pass/,$d' src/src.pro || die "sed _debug suffix failed"

	sed -i -e "s/\(.*\)lib$/\1$(get_libdir)/" src/pcfile.sh || die "sed failed"

	if ! use test; then
		sed -i -e 's/^\(SUBDIRS.*\) tests/\1/' ${PN}.pro || die "sed failed"
	fi
}

src_compile() {
	default
	if use static-libs; then
		emake -C src static || die "emake failed"
	fi
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
	dodoc README CHANGELOG || die "dodoc failed"

	if use static-libs; then
		dolib.a "${S}/lib/lib${PN}.a" || die "dolib failed"
	fi

	if use doc; then
		doxygen "${S}/Doxyfile" || die "Failed to generate documentation"
		dohtml "${S}"/doc/html/* || die "Failed to install documentation"
	fi
}
