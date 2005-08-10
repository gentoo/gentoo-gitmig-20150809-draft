# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/rename/rename-1.3.ebuild,v 1.15 2005/08/10 19:26:41 ciaranm Exp $

inherit toolchain-funcs

DESCRIPTION="tool for easily renaming files"
HOMEPAGE="http://rename.berlios.de/"
SRC_URI="http://download.berlios.de/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc ppc64 ppc-macos x86 amd64"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e '/^CFLAGS/s:-O3:@CFLAGS@:' \
		-e '/strip /s:.*::' \
		Makefile.in
	tc-export CC
}

src_install() {
	newbin rename renamexm || die
	newman rename.1 renamexm.1
	dodoc README ChangeLog
}

pkg_postinst() {
	ewarn "This has been renamed to 'renamexm' to avoid"
	ewarn "a naming conflict with sys-apps/util-linux."
}
