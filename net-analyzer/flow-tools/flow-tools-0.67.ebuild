# Copyright 1999-2005 Gentoo Foundation.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/flow-tools/flow-tools-0.67.ebuild,v 1.1 2005/01/26 19:51:06 angusyoung Exp $

inherit eutils

DESCRIPTION="Flow-tools is a package for collecting and processing NetFlow data"
HOMEPAGE="http://www.splintered.net/sw/flow-tools/"
SRC_URI="ftp://ftp.eng.oar.net/pub/flow-tools/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE="mysql"

DEPEND="virtual/libc
	sys-apps/tcp-wrappers
	sys-libs/zlib"

pkg_setup() {
	enewgroup flowtools
	enewuser flowtools -1 /bin/false /var/lib/flow-tools flowtools
}

src_unpack() {
	unpack ${A}
	cd ${S}/src
	epatch ${FILESDIR}/${P}-nodebug.patch
	epatch ${FILESDIR}/${P}-memleak.patch
}

src_compile() {
	econf \
		`use_with mysql` || die "econf failed"

	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	emake install DESTDIR=${D} || die "emake install failed"
	dodoc COPYING ChangeLog README INSTALL SECURITY TODO

	keepdir /var/lib/flow-tools
}

pkg_postinst() {
	chown flowtools:flowtools /var/lib/flow-tools
	chmod 0750 /var/lib/flow-tools
}
