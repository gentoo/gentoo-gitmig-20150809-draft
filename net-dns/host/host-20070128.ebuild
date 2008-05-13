# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/host/host-20070128.ebuild,v 1.6 2008/05/13 13:41:12 jer Exp $

inherit eutils toolchain-funcs multilib

DESCRIPTION="A powerful command-line DNS query and test tool implementing many additional protocols"
HOMEPAGE="http://www.weird.com/~woods/projects/host.html"
SRC_URI="ftp://ftp.weird.com/pub/local/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ~ppc ~sparc ~x86"
IUSE="debug"

RESTRICT="test"

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd "${S}"

	if ! use debug; then
		sed -i -e "/^CDEBUG/d" \
			-e "/^DEBUGDEFS/d" \
			Makefile || die "src_unpack failed"
	fi

	sed -i	-e "/id-clash-30/d" \
		-e "/^COPT/d" \
		-e "s:^\(LDFLAGS = \)\(-static \)\(.*\):\1\3:" \
		-e "s:^#\(RES_LIB = \)-lresolv:\1/usr/$(get_libdir)/libresolv.a:" \
		-e "s:staff:root:" \
		Makefile || die "src_unpack failed"

	sed -i  -e "s:^\(# if defined(__alpha).*\):\1 || defined(__x86_64__):" \
		port.h || die "src_unpack failed"
}

src_compile() {
	emake CC="$(tc-getCC)" COPTS="${CFLAGS}" || die "emake failed"
}

src_install () {
	# This tool has slightly different format of output from "standard" host.
	# Renaming it to host-woods, hopefully this does not conflict with anything.

	newbin host host-woods || die "newbin failed"
	newman host.1 host-woods.1 || die "newman failed"
	dodoc RELEASE_NOTES ToDo || die "dodoc failed"
}
