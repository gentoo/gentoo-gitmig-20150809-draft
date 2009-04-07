# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/liborigin/liborigin-20090326.ebuild,v 1.1 2009/04/07 20:54:38 bicatali Exp $

EAPI=2
inherit eutils qt4

MYP=${PN}2-${PV}
S="${WORKDIR}/${MYP}"

DESCRIPTION="Library for reading OriginLab OPJ project files"
SRC_URI="mirror://sourceforge/${PN}/${MYP}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/liborigin/"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"

SLOT="2"
IUSE="doc"

RDEPEND="dev-libs/boost
	x11-libs/qt-core:4"
DEPEND="${RDEPEND}
	dev-cpp/tree
	doc? ( app-doc/doxygen )"

src_prepare() {
	cat >> liborigin.pro <<-EOF
		INCLUDEPATH += /usr/include/tree
		headers.files = \$\$HEADERS
		headers.path = /usr/include/liborigin2
		target.path = /usr/$(get_libdir)
		INSTALLS = target headers
	EOF
	# use system one
	rm -f tree.hh || die
}

src_configure() {
	eqmake4
}

src_compile() {
	emake || die "emake failed"
	if use doc; then
		cd doc
		doxygen Doxyfile || die "doc generation failed"
	fi
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
	dodoc README FORMAT
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins -r doc/html || die "doc install failed"
	fi
}
