# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/matew/matew-1.9.ebuild,v 1.1 2004/04/08 17:42:16 scox Exp $

DESCRIPTION="Make Album The Easy Way"
HOMEPAGE="http://matew.sourceforge.net/"

SRC_URI="mirror://sourceforge/matew/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~x86 ~amd64 ~ppc"

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}
	media-gfx/imagemagick
	app-shells/bash
	|| (
		sys-apps/coreutils
		sys-apps/sh-utils
	)"

src_install() {
	exeinto /usr/bin
	doexe ${S}/src/matew ${S}/src/matew-cleanup ${S}/src/matew-wizard
	insinto /etc/matew/styles
	doins ${S}/src/styles/*
	insinto /etc/matew/languages
	doins ${S}/src/languages/*
	dodoc ${S}/doc/AUTHOR ${S}/doc/COPYING ${S}/doc/ChangeLog ${S}/doc/README ${S}/doc/THANKS ${S}/doc/TODO
	doman ${S}/doc/man/matew.1.gz
}

pkg_postinst(){
	einfo "Matew files installed successfully!"
	einfo "Run matew-wizard and read instructions."
}
