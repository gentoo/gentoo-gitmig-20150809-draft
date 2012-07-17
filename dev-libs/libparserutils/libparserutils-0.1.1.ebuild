# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libparserutils/libparserutils-0.1.1.ebuild,v 1.2 2012/07/17 21:43:44 xmw Exp $

EAPI=4

inherit flag-o-matic multilib toolchain-funcs

DESCRIPTION="library for building efficient parsers, written in C"
HOMEPAGE="http://www.netsurf-browser.org/projects/libparserutils/"
SRC_URI="http://download.netsurf-browser.org/libs/releases/${P}-src.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm"
IUSE="iconv static-libs"

RDEPEND=""
DEPEND="test? (	dev-lang/perl )"

src_prepare() {
	sed -e "/^INSTALL_ITEMS/s: /lib: /$(get_libdir):g" \
		-e "s:-Werror::g" \
		-i Makefile || die
	sed -e "/^libdir/s:/lib:/$(get_libdir):g" \
		-i ${PN}.pc.in || die
	echo "Q := " >> Makefile.config.override || die
	echo "CC := $(tc-getCC)" >> Makefile.config.override || die
	echo "AR := $(tc-getAR)" >> Makefile.config.override || die
}

src_configure() {
	if use iconv ; then
		append-cflags "-DWITH_ICONV_FILTER"
	else
		append-cflags "-DWITHOUT_ICONV_FILTER"
	fi
}

src_compile() {
	emake COMPONENT_TYPE=lib-shared
	if use static-libs ; then
		emake COMPONENT_TYPE=lib-static
	fi
	if use doc ; then
		emake doc
	fi
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr install
	if use static-libs ; then
		emake COMPONENT_TYPE=lib-static DESTDIR="${D}" PREFIX=/usr install || die
	fi
	dodoc README docs/Todo
}
