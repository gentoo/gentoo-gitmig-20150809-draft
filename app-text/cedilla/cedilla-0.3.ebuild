# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/cedilla/cedilla-0.3.ebuild,v 1.5 2004/04/07 21:38:04 vapier Exp $

inherit eutils

DESCRIPTION="Utf-8 to postscript converter."
HOMEPAGE="http://www.pps.jussieu.fr/~jch/software/cedilla/"
SRC_URI="http://www.pps.jussieu.fr/~jch/software/files/${P}.tar.gz"

KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=dev-lisp/clisp-2.29
	>=sys-apps/sed-4"
RDEPEND=""

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/cedilla-gentoo.patch
}
src_compile() {
	./compile-cedilla || die "Compile failed"
}

src_install() {
	sed -i 's#/var/tmp/portage/cedilla-0.3/image##g' ${S}/cedilla
	./install-cedilla || die "Install failed"

	newman cedilla.man cedilla.1
	dodoc NEWS README
}
