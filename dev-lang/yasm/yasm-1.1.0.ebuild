# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/yasm/yasm-1.1.0.ebuild,v 1.2 2010/10/29 10:53:59 hwoarang Exp $

EAPI=2
PYTHON_DEPEND="python? 2:2.4"

inherit autotools eutils python

DESCRIPTION="An assembler for x86 and x86_64 instruction sets"
HOMEPAGE="http://www.tortall.net/projects/yasm/"
SRC_URI="http://www.tortall.net/projects/yasm/releases/${P}.tar.gz"

LICENSE="Artistic BSD GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="-* amd64 ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x64-macos ~x86-macos ~x86-solaris"
IUSE="nls python"

RDEPEND="nls? ( virtual/libintl )"
DEPEND="nls? ( sys-devel/gettext )
	python? ( >=dev-python/cython-0.11.3 )"

pkg_setup() {
	if use python; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.1.0-skip_cython_check.patch
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable python) \
		$(use_enable python python-bindings) \
		--disable-dependency-tracking \
		$(use_enable nls)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS
}
