# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/moreutils/moreutils-0.30.ebuild,v 1.1 2008/05/15 14:41:22 gregkh Exp $

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
	# any patches?
}

src_compile() {
	cd "${WORKDIR}/moreutils"
	emake CFLAGS="${CFLAGS}" DOCBOOK2XMAN="docbook2man.pl" || die "emake failed"
}

src_install() {
	cd "${WORKDIR}/moreutils"
	emake DESTDIR="${D}" install || die "install failed"
}
