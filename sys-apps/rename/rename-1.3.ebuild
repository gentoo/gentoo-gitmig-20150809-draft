# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/rename/rename-1.3.ebuild,v 1.7 2004/09/12 12:14:59 port001 Exp $

DESCRIPTION="Rename is a tool for renaming files. It supports extended regular expressions."
SRC_URI="http://rename.berlios.de/rename-1.3.tar.gz"
HOMEPAGE="http://rename.berlios.de/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc macos ppc64"
IUSE=""

src_compile() {
	econf --prefix=/usr || die "Failed to configure"
	emake || die "Failed to compile"
}

src_install() {
	dobin rename
	doman rename.1
	dodoc README ChangeLog
}
