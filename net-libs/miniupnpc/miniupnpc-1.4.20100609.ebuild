# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/miniupnpc/miniupnpc-1.4.20100609.ebuild,v 1.1 2010/09/15 08:40:36 pva Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"
PYTHON_DEPEND="python? 2"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils toolchain-funcs

DESCRIPTION="UPnP client library and a simple UPnP client"
HOMEPAGE="http://miniupnp.free.fr/"
SRC_URI="http://miniupnp.free.fr/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="python static-libs"

src_prepare() {
	epatch "${FILESDIR}/${PN}-Respect-LDFLAGS.patch"
	epatch "${FILESDIR}/0003-Move-non-used-and-non-installed-test-executables-to-.patch"
	epatch "${FILESDIR}/0004-Move-minixml-validation-test-to-check-target.patch"

	sed \
		-e 's/^CFLAGS ?= -O -Wall /CFLAGS += /' \
		-i Makefile

	if use !static-libs; then
		sed \
			-e '/FILESTOINSTALL =/s/ $(LIBRARY)//' \
			-e '/$(INSTALL) -m 644 $(LIBRARY) $(INSTALLDIRLIB)/d' \
			-i Makefile
	fi

	use python && distutils_src_prepare
}

src_compile() {
	emake CC=$(tc-getCC) || die

	use python && distutils_src_compile
}

src_install() {
	emake \
		PREFIX="${D}" \
		INSTALLDIRLIB="${D}usr/$(get_libdir)" \
		install || die

	dodoc README Changelog.txt || die
	doman man3/* || die

	use python && distutils_src_install
}

pkg_postinst() {
	use python && distutils_pkg_postinst
}

pkg_postrm() {
	use python && distutils_pkg_postrm
}
