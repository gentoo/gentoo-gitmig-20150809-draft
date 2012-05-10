# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/miniupnpc/miniupnpc-1.6-r1.ebuild,v 1.5 2012/05/10 06:26:07 phajdan.jr Exp $

EAPI=4

inherit base toolchain-funcs

DESCRIPTION="UPnP client library and a simple UPnP client"
HOMEPAGE="http://miniupnp.free.fr/"
SRC_URI="http://miniupnp.free.fr/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm ppc ppc64 x86"
IUSE="static-libs"

RESTRICT="test"

DEPEND="sys-apps/lsb-release"
RDEPEND=""

src_prepare() {
	base_src_prepare

	sed \
		-e 's/^CFLAGS ?= -O -Wall /CFLAGS += /' \
		-i Makefile || die

	if use !static-libs; then
		sed \
			-e '/FILESTOINSTALL =/s/ $(LIBRARY)//' \
			-e '/$(INSTALL) -m 644 $(LIBRARY) $(INSTALLDIRLIB)/d' \
			-i Makefile || die
	fi
}

# Upstream cmake causes more trouble than it fixes,
# so we'll just stay with the Makefile for now.

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	emake \
		PREFIX="${D}" \
		INSTALLDIRLIB="${D}usr/$(get_libdir)" \
		install

	dodoc README Changelog.txt
	doman man3/*
}

pkg_postinst() {
	elog "Please note that the python counterpart has been moved to"
	elog "	dev-python/miniupnpc"
}
