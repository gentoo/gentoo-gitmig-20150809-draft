# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/cedilla/cedilla-0.6.ebuild,v 1.1 2011/10/20 13:05:13 titanofold Exp $

EAPI="4"

inherit eutils

DESCRIPTION="UTF-8 to postscript converter."
HOMEPAGE="http://www.pps.jussieu.fr/~jch/software/cedilla/"
SRC_URI="http://www.pps.jussieu.fr/~jch/software/files/${P}.tar.gz"

KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="dev-lisp/clisp"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/cedilla-gentoo-r1.patch
}

src_compile() {
	./compile-cedilla || die "Compile failed."
}

src_install() {
	sed -i "s#${ED%/}##g" cedilla || die "sed failed"
	newman cedilla.man cedilla.1
	./install-cedilla || die "Install failed."
	dodoc NEWS README
}
