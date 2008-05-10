# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/moreutils/moreutils-0.29.ebuild,v 1.1 2008/05/10 05:39:50 gregkh Exp $

inherit eutils

DESCRIPTION="a growing collection of the unix tools that nobody thought to write
thirty years ago"
HOMEPAGE="http://kitenet.net/~joey/code/moreutils/"
SRC_URI="http://ftp.de.debian.org/debian/pool/main/m/moreutils/moreutils_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}
	app-text/docbook2X"

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}/moreutils"
	epatch "${FILESDIR}/docbook-makefile.patch"
}

src_compile() {
	cd "${WORKDIR}/moreutils"
	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	cd "${WORKDIR}/moreutils"
	emake PREFIX="${D}" install || die "install failed"
}
